"""
Extract: download the Olist Brazilian e-commerce public dataset into data/raw.

Olist published ~100k real, anonymized marketplace orders (2016-2018) under
CC BY-NC-SA 4.0. This pulls the eight relational tables from a public mirror of
the original Kaggle release and writes a manifest (URL, rows, bytes, SHA-256)
so every figure on the dashboard can be traced back to a file.

    python ingest/extract.py            # download
    python ingest/extract.py --offline  # rebuild the manifest from files on disk
"""
from __future__ import annotations

import argparse
import hashlib
import json
import time
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
BASE = "https://raw.githubusercontent.com/dujiaying/olist/master/data"

# raw table name -> file in the Olist release
SOURCES = {
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "order_payments": "olist_order_payments_dataset.csv",
    "order_reviews": "olist_order_reviews_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "products": "olist_products_dataset.csv",
    "category_translation": "product_category_name_translation.csv",
}


def fetch(url: str, attempts: int = 4) -> bytes:
    for i in range(attempts):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "commerce-pulse-extract/1.0"})
            with urllib.request.urlopen(req, timeout=120) as r:
                return r.read()
        except Exception as exc:
            if i == attempts - 1:
                raise SystemExit(f"Failed to fetch {url}: {exc}")
            time.sleep(2 ** i)
    raise AssertionError("unreachable")


def count_rows(path: Path) -> int:
    # quoted review comments contain newlines, so count records with the csv module
    import csv
    with path.open(newline="", encoding="utf-8") as f:
        return sum(1 for _ in csv.reader(f)) - 1


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--offline", action="store_true")
    args = ap.parse_args()
    RAW.mkdir(parents=True, exist_ok=True)
    manifest = []
    for table, file in SOURCES.items():
        url, out = f"{BASE}/{file}", RAW / f"{table}.csv"
        if not args.offline:
            out.write_bytes(fetch(url))
        elif not out.exists():
            raise SystemExit(f"--offline but {out.name} is missing")
        body = out.read_bytes()
        rows = count_rows(out)
        manifest.append({"table": table, "file": out.name, "url": url, "bytes": len(body), "rows": rows,
                         "sha256": hashlib.sha256(body).hexdigest(),
                         "fetched_at": datetime.now(timezone.utc).isoformat(timespec="seconds")})
        print(f"  {table:<22} {rows:>9,} rows  {len(body) / 1e6:>6.1f} MB")
    (RAW / "_manifest.json").write_text(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()

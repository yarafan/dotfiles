vim.g.db_ui_use_nerd_fonts = 1

vim.g.dbs = {
  { name = "[DEV] Shard 1",      url = "postgresql://postgres:postgres@localhost:5491/discounts_prices" },
  { name = "[DEV] Shard 2",      url = "postgresql://postgres:postgres@localhost:5492/discounts_prices" },
  { name = "[DEV] Shard 3",      url = "postgresql://postgres:postgres@localhost:5493/discounts_prices" },
  { name = "[DEV] Shard 4",      url = "postgresql://postgres:postgres@localhost:5494/discounts_prices" },
  { name = "[DEV] Shard 5",      url = "postgresql://postgres:postgres@localhost:5495/discounts_prices" },
  { name = "[Stage] Shard 1",    url = "postgresql://dp_afanasev_yaroslav_ro:YgswA-hm7KvsTwWbn3YT@discounts-prices-prices-pgsql-stage-cl1-haproxy.discounts-prices.k8s.portal-stage-el:5003/discounts_prices" },
  { name = "[Stage] Shard 2",    url = "postgresql://dp_afanasev_yaroslav_ro:YgswA-hm7KvsTwWbn3YT@discounts-prices-prices-pgsql-stage-cl2-haproxy.discounts-prices.k8s.portal-stage-el:5003/discounts_prices" },
  { name = "[Stage][W] Shard 2", url = "postgresql://admin:hZz9AoPlxItRcg7xATN5GNANcjy7EOTJ@discounts-prices-prices-pgsql-stage-cl2-haproxy.discounts-prices.k8s.portal-stage-el:5000/discounts_prices" },
  { name = "[Stage] Shard 3",    url = "postgresql://dp_afanasev_yaroslav_ro:YgswA-hm7KvsTwWbn3YT@discounts-prices-prices-pgsql-stage-cl3-haproxy.discounts-prices.k8s.portal-stage-el:5003/discounts_prices" },
  { name = "[Stage] Shard 4",    url = "postgresql://dp_afanasev_yaroslav_ro:YgswA-hm7KvsTwWbn3YT@discounts-prices-prices-pgsql-stage-cl4-haproxy.discounts-prices.k8s.portal-stage-el:5003/discounts_prices" },
  { name = "[Stage] Shard 5",    url = "postgresql://dp_afanasev_yaroslav_ro:YgswA-hm7KvsTwWbn3YT@discounts-prices-prices-pgsql-stage-cl5-haproxy.discounts-prices.k8s.portal-stage-el:5003/discounts_prices" },
  { name = "[Prod] Shard 1",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl1-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 2",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl2-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 3",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl3-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 4",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl4-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 5",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl5-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 6",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl6-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 7",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl7-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 8",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl8-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 9",     url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl9-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 10",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl10-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 11",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl11-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 12",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl12-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 13",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl13-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 14",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl14-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
  { name = "[Prod] Shard 15",    url = "postgresql://dp_afanasev_yaroslav_ro:fhUshj457389Kio46378Ki@discounts-prices-price-pgsql-cl15-haproxy.discounts-prices.k8s.portal-dl:5000/discounts_prices" },
}

-- vim.g.db_ui_table_helpers = {
-- 	postgresql = {
-- 		Count = 'select count(*) from {optional_schema}{table}',
-- 		Explain = 'EXPLAIN ANALYZE {last_query}'
-- 	}
-- }

# Data Scraper

Currently there is an API for Zillow but you need approval and it is hard to understand.
In the future that would be the ideal case.

For now go with a scraping model. Scrape an area and place the records into a database. 
They can live there for ~30 days until they are considered stale. Whenever a new game is started more can be scraped.
Somehow make a way to not show the same houses to the players who play again.


I am scraping some hacky script tag on the zillow page. Might not be reliable. Currently just stored as the `jsondata.json` file
all facilities and its users (ok)

all products and which program it belongs to (ok)

latest stock on hands of each drug of facilities, expire date included (the ones without expiration date are missing)

all movements histories, signature included (the ones without signatures are missing)

all VIA requisition histories (theory soh is missing now) need signature, committed time, synced time

all MMIA requisition histories (theory soh is missing now)

regimens and quantification of patients of each requisition

filter by date range is not in scope for now.

8 csv files in a zip file

facilities csv: [http://localhost:5555/cube/facilities/facts?format=csv](http://localhost:5555/cube/facilities/facts?format=csv)

products csv: [[http://localhost:5555/cube/requisition_line_items/members/products?format=csv](http://localhost:5555/cube/requisition_line_items/members/products?format=csv))

latest stock at different facilities: [http://localhost:5555/cube/stock_cards/members/stock?cut=stock:expirationdates&format=csv](http://localhost:5555/cube/stock_cards/members/stock?cut=stock:expirationdates&format=csv)

movement history:  [http://localhost:5555/cube/stock_cards/members/movement?cut=movement:signature&format=csv](http://localhost:5555/cube/stock_cards/members/movement?cut=movement:signature&format=csv)

requisition mmia: [http://localhost:5555/cube/requisition_line_items/facts?cut=products:MMIA&format=csv](http://localhost:5555/cube/requisition_line_items/facts?cut=products:MMIA&format=csv)

requisition via: [http://localhost:5555/cube/requisition_line_items/facts?cut=products:ESS_MEDS&format=csv](http://localhost:5555/cube/requisition_line_items/facts?cut=products:ESS_MEDS&format=csv)

regimens: [http://localhost:5555/cube/requisitions/members/regimen?format=csv](http://localhost:5555/cube/requisitions/members/regimen?format=csv)

patient quantification: [http://localhost:5555/cube/requisitions/members/patient_quantification?format=csv](http://localhost:5555/cube/requisitions/members/patient_quantification?format=csv)

Spike: 
select date range could be done like this
http://localhost:5555/cube/stock_card_entries/facts?cut=date:2015,11,10-2015,11,15|others:ADJUSTMENT

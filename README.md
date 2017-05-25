Online rent parser
==================
  Description
  -----------
    It provides parsing apartments descriptions using input options. Output format json or csv.
  You can range apartments using sort option.
  
  Default parameters 
  ------------------
    sort = false, output_format = json, outout_path = root
    
  How to run
  ----------
  * type `ruby script.rb`
  * type `ruby script.rb [options]`, where [options] => 
    * `-rRENT_TYPE, --rent_type RENT_TYPE` possible values: `room,1_room,2_rooms,3_rooms,4_rooms,5_rooms,6_rooms` (default)
    * `--price_min PRICE_MIN` possible values: `50 - 8500` (default - 50)
    * `--price_max PRICE_MAX` possible values: `50 - 8500` (default - 8500)
    * `-mMETRO, --metro METRO` possible values: `red_line,blue_line`  (default)
    * `-oOWNER, --owner OWNER` possible values: `true` (default - false)
    * `-sSORT, --sort SORT` possible values: `true` (default - false)
    * `-fFORMAT, --file_format FORMAT` possible values: `csv or json` (default - json)
    * `-pPATH, --path PATH` (default - root)
  

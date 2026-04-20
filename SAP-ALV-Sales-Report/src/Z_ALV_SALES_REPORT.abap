REPORT Z_ALV_SALES_REPORT.

TYPES: BEGIN OF ty_sales,
         order_id TYPE string,
         customer TYPE string,
         product  TYPE string,
         amount   TYPE i,
       END OF ty_sales.

DATA: lt_sales TYPE TABLE OF ty_sales,
      ls_sales TYPE ty_sales.

* Sample Data
lt_sales = VALUE #(
  ( order_id = '1001' customer = 'Rahul' product = 'Laptop' amount = 50000 )
  ( order_id = '1002' customer = 'Sneha' product = 'Phone' amount = 20000 )
  ( order_id = '1003' customer = 'Amit' product = 'Tablet' amount = 15000 )
  ( order_id = '1004' customer = 'Rahul' product = 'Monitor' amount = 10000 )
).

* Selection Screen
PARAMETERS: p_cust TYPE string.

* Filter Logic
IF p_cust IS NOT INITIAL.
  DELETE lt_sales WHERE customer <> p_cust.
ENDIF.

* ALV Display
DATA: lo_alv TYPE REF TO cl_salv_table.

cl_salv_table=>factory(
  IMPORTING r_salv_table = lo_alv
  CHANGING  t_table      = lt_sales ).

lo_alv->display( ).

* Total Calculation
DATA: lv_total TYPE i VALUE 0.

LOOP AT lt_sales INTO ls_sales.
  lv_total = lv_total + ls_sales-amount.
ENDLOOP.

WRITE: / 'Total Sales:', lv_total.

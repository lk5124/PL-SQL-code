DECLARE

    CURSOR c_proc IS
    select product_id from products
    where product_name like '%Xeon%';

    TYPE t_List	IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_List		t_List;
    ln_i		NUMBER;
    n number:=0;

BEGIN

    OPEN c_proc;
    FETCH c_proc BULK COLLECT INTO v_List;
    CLOSE c_proc;

    ln_i:=v_List.COUNT();

    for i in 1..ln_i LOOP
        update order_items
        set quantity = quantity - 1
        where product_id =v_List(i);

    END LOOP;
    COMMIT;
END;
set serveroutput on;

create or replace procedure baixa_producte (var_prod_cod in product.product_code%type)
is 

var_prod number;

cursor c1 is 
select * from product where var_prod_cod = product_code;
cont int := 0;

begin

open c1;
    loop
        fetch c1 into var_prod;
		cont := cont + 1;
    exit when c1%notfound;
    end loop;
close c1;
if cont = 0 then 
    dbms_output.put_line('El producto no existe.');
    
elsif cont = 1 then
    select count(*) into var_prod from order2 where product_code = var_prod_cod;
    if var_prod = 0 then
        delete from product where product_code = var_prod_cod;
        dbms_output.put_line('El producto se ha eliminado satisfactoriamente.');
    elsif var_prod >= 1 then
    dbms_output.put_line('No se puede eliminar el producto ya que existe en otra tabla');
    end if;
end if;
end;

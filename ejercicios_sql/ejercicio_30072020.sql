--- Ejercicios 30072020

CREATE TABLE public.movimientos
(
    id integer NOT NULL,
    origen integer NOT NULL,
    destino integer NOT NULL,
    monto numeric(12, 2) NOT NULL,
    PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.movimientos
    OWNER to postgres;

CREATE SEQUENCE public.seq_movimientos
    INCREMENT 1
    START 1
    MINVALUE 1;

ALTER SEQUENCE public.seq_movimientos
    OWNER TO postgres;

-- Obtener el siguiente valor de una secuencia.
SELECT nextval('seq_movimientos');

-- Obtener el valor actual de una secuencia.
SELECT currval('seq_movimientos');

-- Crea una tabla a partir de una consulta, sin registros
create table grandes_movimientos as (select * from
movimientos where 0=1);

-- TRIGGER

CREATE OR REPLACE FUNCTION public.fnc_grandes_movimientos()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL  
  AS
$$
BEGIN
	IF NEW.monto >=10000 THEN
		 INSERT INTO grandes_movimientos(id,origen,destino,monto)
		 VALUES(NEW.id,NEW.origen,NEW.destino,NEW.monto);
	END IF;

	RETURN NEW;
END;
$$


CREATE TRIGGER trg_grandes_movimientos
  AFTER INSERT
  ON public.movimientos
  FOR EACH ROW
  EXECUTE PROCEDURE fnc_grandes_movimientos();


---- OPERACIONES: Probamos el trigger insertando registros.

select * from public.grandes_movimientos;

insert into public.movimientos (id, origen , destino , monto)
values ( nextval('seq_movimientos'), 4444, 5555, 9900);

insert into public.movimientos (id, origen , destino , monto)
values ( nextval('seq_movimientos'), 6666, 7777, 10500);

select * from public.grandes_movimientos;

---- AUDITORIA

create table public.aud_m as (select * from public.movimientos where 0=1);

ALTER TABLE public.aud_m ADD COLUMN fmod date;

ALTER TABLE public.aud_m ADD COLUMN umod character varying(10);


-- TRIGGER AUDITORIA

CREATE OR REPLACE FUNCTION public.fnc_audit_movimientos()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL  
  AS
$$
BEGIN
	INSERT INTO aud_m(id,origen,destino,monto,fmod,umod)
		 VALUES(OLD.id,OLD.origen,OLD.destino,OLD.monto,now(),current_user);
	RETURN NEW;
END;
$$

--- 

CREATE TRIGGER trg_audit_movimientos
  AFTER UPDATE
  ON public.movimientos
  FOR EACH ROW
  EXECUTE PROCEDURE fnc_audit_movimientos();
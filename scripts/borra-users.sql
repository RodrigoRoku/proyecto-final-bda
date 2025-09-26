
connect sys/system3 as sysdba

drop user if exists c##tana_bkp cascade;

connect sys/system3@tana_ventas as sysdba

drop user if exists tana_ventas cascade;

connect sys/system3@tana_subastas as sysdba

drop user if exists tana_subastas cascade;
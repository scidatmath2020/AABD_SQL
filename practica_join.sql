create table tsdem(
	control char(7),
	viv_sel char(2),
	Hogar char(2),
	N_ren char(2),
	SEXO int,
	EDAD int
)

create table tper_vic(
	control char(7),
	viv_sel char(2),
	Hogar char(2),
	R_sel char(2),
	fac_ele int
)


create table tmod_vic(
	control char(7),
	viv_sel char(2),
	Hogar char(2),
	ND_tipo int,
	TD_tipo int,
	BP_COD char(2),
	R_sel char(2),
	Entidad_ocurrencia char(2),
	fac_del int
)

create table tsdem_ext as
select concat(control,'_',viv_sel,'_',hogar,'_',n_ren) as ID, *
from tsdem

create table tper_vic_ext as
select concat(control,'_',viv_sel,'_',hogar,'_',r_sel) as ID, *
from tper_vic

create table tmod_vic_ext as
select concat(control,'_',viv_sel,'_',hogar,'_',r_sel) as ID, *
from tmod_vic

------

select * from tper_vic_ext

-- El sexo está guardado en la tabla tsdem, así como la edad. Lo que tenemos que hacer es
-- jalar el sexo y la edad desde tsdem hasta tper_vic utilizando el ID

select sum(fac_ele) from 
tper_vic_ext
left join 
tsdem_ext
on tper_vic_ext.id = tsdem_ext.id
 
create table tper_vic_ent as
select substr(control,1,2) as cod_ent, *
from tper_vic_ext

----- En este momento, en tper_vic_ent tenemos entidad y id. Sigue
----- colocar el sexo mediante el ID con tsdem

create table tper_vic_sex As
	SELECT tper_vic_ent.cod_ent, tper_vic_ent.id, tper_vic_ent.control, 
		   tper_vic_ent.viv_sel, 
		   tper_vic_ent.hogar, 
		   tper_vic_ent.r_sel, 
		   tper_vic_ent.fac_ele, 
		   tsdem_ext.sexo,
		   tsdem_ext.edad
FROM tper_vic_ent
LEFT JOIN tsdem_ext 
ON tper_vic_ent.id = tsdem_ext.id;

create table tper_vic_FACDEL As
	SELECT tper_vic_sex.cod_ent, tper_vic_sex.id as ID_tper_vic, tper_vic_sex.fac_ele, 
		   tmod_vic_ext.id as ID_tmod_vic,
		   tmod_vic_ext.FAC_DEL
FROM tper_vic_sex
LEFT JOIN tmod_vic_ext 
ON tper_vic_sex.id = tmod_vic_ext.id;

select sum(FAC_ELE) from tper_vic_FACDEL where fac_del is not null
select sum(FAC_DEL) from tmod_vic

--Añadir a tmod_vic una columna donde aparezca la descripción del delito

--Añadir a tmod_vic una columna con un texto como el siguiente: "Esta persona
--fue víctima del delito DESCRIPCIÓN DEL DELITO y tiene XX años de edad"

--Cuántas personas fueron víctimas de delito en tu entidad











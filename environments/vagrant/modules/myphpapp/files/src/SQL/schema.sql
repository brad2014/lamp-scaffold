# schema for myphpapp version 1.0

create table myphpapp_version (
  myphpapp_component varchar(24) primary key,
  myphpapp_version   varchar(10) not null
);

create table myphpapp_widget (
  myphpapp_color    varchar(24) primary key,
  myphpapp_count    integer not null default 0
);

insert into myphpapp_version values ( 'myphpapp', '1.0' );

create database flink;
use flink;

drop table if exists chain_link_deal;
drop table if exists network;

create table network
(
  id                bigint       not null auto_increment,
  name              varchar(255) not null,
  api_url           varchar(128) not null,
  description       varchar(2000),
  primary key pk_network (id),
  unique key un_network_name (name),
  unique key un_network_api_url (api_url)
) engine=InnoDB;

insert into network(name,api_url) values("filecoin_mainnet", "https://api.filscan.io:8700/rpc/v1");
insert into network(name,api_url) values("filecoin_calibration", "https://calibration.filscan.io:8700/rpc/v1");


create table chain_link_deal(
    id                         bigint        not null auto_increment,
    deal_id                    bigint        not null,
    network_id                 bigint        not null,
    deal_cid                   varchar(1000) , #--not null,
    message_cid                varchar(1000) , #--not null,
    height                     bigint        , #--not null,
    piece_cid                  varchar(1000) , #--not null,
    verified_deal              boolean       , #--not null,
    storage_price_per_epoch    bigint        , #--not null,
    signature                  varchar(1000) , #--not null,
    signature_type             varchar(60)   , #--not null,
    created_at                 bigint        , #--not null, #--precision:second
    piece_size                 varchar(60)   , #--not null,
    start_height               bigint        , #--not null,
    end_height                 bigint        , #--not null,
    client                     varchar(200)  , #--not null, #--wallet
    client_collateral_format   varchar(60)   , #--not null,
    provider                   varchar(60)   , #--not null,
    provider_tag               varchar(1000) ,
    verified_provider          int           , #--not null,
    provider_collateral_format varchar(60)   , #--not null,
    status                     int           , #--not null,
    storage_price              bigint        ,
    primary key pk_chain_link_deal(id),
    unique key un_chain_link_deal_network_id_deal_id (deal_id, network_id),
    constraint fk_chain_link_deal_network_id foreign key (network_id) references network (id)
);

ALTER TABLE flink.chain_link_deal drop column  piece_size_format;
ALTER TABLE flink.chain_link_deal add column  piece_size varchar(30);


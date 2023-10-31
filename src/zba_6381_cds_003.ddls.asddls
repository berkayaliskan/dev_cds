@AbapCatalog.sqlViewName: 'ZBA_6381_V003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: false
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Examples 4'
define view ZBA_6381_CDS_003
  as select from ZBA_6381_CDS_002
{
  vbeln,
  sum(conversion_netwr)                                                                       as sum_netwr,
  kunnrAd,
  count(*)                                                                                    as count_vbeln,
  division(cast(sum(conversion_netwr) as abap.curr( 10, 2 )), cast(count(*) as abap.int1), 2) as average_netwr,
  substring(fkdat,1,4)                                                                        as substring_year,
  substring(fkdat,5,2)                                                                        as substring_mounth,
  substring(fkdat,7,2)                                                                        as substring_day,
  substring_inco2_l

}
group by
  vbeln,
  kunnrAd,
  fkdat,
  substring_inco2_l

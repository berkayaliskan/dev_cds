@AbapCatalog.sqlViewName: 'ZBA_6381_V002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Examples 3'
define view ZBA_6381_CDS_002
  as select from    vbrp
    inner join      vbrk on vbrp.vbeln = vbrk.vbeln
    inner join      mara on vbrp.matnr = mara.matnr
    left outer join vbak on vbrp.aubel = vbak.vbeln
    left outer join kna1 on vbak.kunnr = kna1.kunnr
    left outer join makt on mara.matnr = makt.matnr
{
  key vbrp.vbeln,
  key vbrp.posnr,
      vbrp.aubel,
      vbrp.aupos,
      vbak.kunnr,
      concat_with_space(kna1.name1,kna1.name2,1)              as kunnrAd,
      @Semantics.currencyCode: true
      vbrp.waerk ,
      currency_conversion( amount => vbrp.netwr,
                           source_currency => vbrk.waerk,
                           target_currency => cast('EUR' as abap.cuky),                         
                           exchange_rate_date => vbrk.fkdat ) as conversion_netwr,
      left(kna1.kunnr,3)                                      as left_kunnr,
      length(mara.matnr)                                      as matnr_length,
      case vbrk.fkart
          when 'FAS' then 'Peşinat talebi iptali'
          when 'FAZ' then 'Peşinat talebi'
          else 'Fatura'
          end                                                 as CaseSt_fkart,
      vbrk.fkdat,
      substring(vbrk.inco2_l,1,3) as substring_inco2_l

}

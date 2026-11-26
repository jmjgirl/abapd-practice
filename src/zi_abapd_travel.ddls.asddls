@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel View'
define view entity ZI_ABAPD_TRAVEL 
       as select from zabapd_travel
{
    key travel_id  as TravelId,
    agency_id      as AgencyId,
    description    as Description,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price    as TotalPrice,
    currency_code  as CurrencyCode,
    status         as Status,
    case status
      when 'O' then 'Open'
      when 'A' then 'Accepted'
      else 'Unknown'
    end            as StatusText
}

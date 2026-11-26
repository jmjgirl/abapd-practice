@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Projection'
@Metadata.allowExtensions: true
define root view entity ZC_ABAPD_TRAVEL 
       provider contract transactional_query
       as projection on ZR_ABAPD_TRAVEL
{
    key TravelId,
        AgencyId,
        Description,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        TotalPrice,
        CurrencyCode,
        Status,
        StatusText,
        LocalLastChangedAt,
        LastChangedAt
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_ABAPD_TRAVEL 
    as select from zabapd_travel
{
    key travel_id             as TravelId,
        agency_id             as AgencyId,
        @EndUserText.label: 'Description'
        description           as Description,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        @EndUserText.label: 'Total Price'
        total_price           as TotalPrice,
        @EndUserText.label: 'Currency'
        currency_code         as CurrencyCode,
        @EndUserText.label: 'Status'
        status                as Status,
        @EndUserText.label: 'Status Text'
        case status
          when 'O' then 'Open'
          when 'A' then 'Accepted'
          else 'Unknown'
        end                   as StatusText,
        @Semantics.user.createdBy: true
        local_created_by      as LocalCreatedBy,
        @Semantics.systemDateTime.createdAt: true
        local_created_at      as LocalCreatedAt,
        @Semantics.user.localInstanceLastChangedBy: true
        local_last_changed_by as LocalLastChangedBy,
        @Semantics.systemDateTime.localInstanceLastChangedAt: true
        local_last_changed_at as LocalLastChangedAt,
        @Semantics.systemDateTime.lastChangedAt: true
        last_changed_at       as LastChangedAt
}

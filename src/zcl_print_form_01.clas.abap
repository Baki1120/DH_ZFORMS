CLASS zcl_print_form_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRINT_FORM_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lv_xml_data TYPE xstring.
    DATA lv_xdp TYPE xstring.
    DATA ls_options TYPE cl_fp_ads_util=>ty_gs_options_pdf.
    DATA ev_pdf TYPE xstring.
    DATA ev_pages TYPE int4.
    DATA ev_trace_string TYPE string.
    " DATA(lv_xdp) = 'YY1_SDBIL_CI_STANDARD_US_E'.


*    TRY.
*        DATA(lo_fdp_api) = cl_fp_fdp_services=>get_instance( `YY1_SDBIL_CI_STANDARD_US` ).
*      CATCH cx_fp_fdp_error INTO DATA(lo_fdp).
*        out->write( lo_fdp->get_text( ) ).
*
*    ENDTRY.
*
*    DATA(lt_keys) = lo_fdp_api->get_keys( ).

    lv_xdp = |YY1_SDBIL_CI_STANDARD_US|.
    lv_xml_data =
|<?xml version="1.0" encoding="UTF-8"?>| &&
|<Form>| &&
|   <BillingDocumentNode>| &&
|      <AbsltAccountingExchangeRate/>| &&
|      <AcctgExchangeRateIsIndrctQtan/>| &&
|      <BillingDate>20040606T101010</BillingDate>| &&
|      <BillingDocument>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</BillingDocument>| &&
|      <BillingDocumentCategory>Mirum est</BillingDocumentCategory>| &&
|      <BillingDocumentType/>| &&
|      <BillingDocumentTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</BillingDocumentTypeName>| &&
|      <BillingSDDocumentCategory>Licebit auctore</BillingSDDocumentCategory>| &&
|      <BillingSDDocumentCategoryName>Proinde</BillingSDDocumentCategoryName>| &&
|      <CancelledBillingDocument>Am undique</CancelledBillingDocument>| &&
|      <CompanyCodeCurrency/>| &&
|      <DocumentReferenceID/>| &&
|      <ExchangeRateDate/>| &&
|      <InvoiceListStatus>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</InvoiceListStatus>| &&
|      <NumberOfSourceCurrencyUnits/>| &&
|      <NumberOfTargetCurrencyUnits/>| &&
|      <PrelimBillingDocument/>| &&
|      <PricingProcedure/>| &&
|      <PurchaseOrderByCustomer>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</PurchaseOrderByCustomer>| &&
|      <ReferenceSDDocument>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ReferenceSDDocument>| &&
|      <ReferenceSDDocumentCategory/>| &&
|      <ReferenceSDDocumentCategoryName>Mirum est ut animus agitatione motuque corporis excitetut.</ReferenceSDDocumentCategoryName>| &&
|      <SalesContract>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</SalesContract>| &&
|      <SalesDocument>Mirum est ut animus agitatione motuque corporis excitetut.</SalesDocument>| &&
|      <SalesOrganization/>| &&
|      <SalesOrganizationName/>| &&
|      <SalesSDDocumentCategory/>| &&
|      <SalesSDDocumentCategoryName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</SalesSDDocumentCategoryName>| &&
|      <SolutionOrder>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</SolutionOrder>| &&
|      <TotalGrossAmount>9.94</TotalGrossAmount>| &&
|      <TotalNetAmount>9.15</TotalNetAmount>| &&
|      <TotalTaxAmount>5.52</TotalTaxAmount>| &&
|      <TransactionCurrency>Apros tres et quidem</TransactionCurrency>| &&
|      <BillToParty>| &&
|         <AddressID/>| &&
|         <AddressLine1Text/>| &&
|         <AddressLine2Text/>| &&
|         <AddressLine3Text/>| &&
|         <AddressLine4Text/>| &&
|         <AddressLine5Text/>| &&
|         <AddressLine6Text/>| &&
|         <AddressLine7Text/>| &&
|         <AddressLine8Text/>| &&
|         <AddressType/>| &&
|         <FullName/>| &&
|         <Partner/>| &&
|         <PartnerFunction/>| &&
|         <PartnerFunctionName/>| &&
|         <Person/>| &&
|      </BillToParty>| &&
|      <Company>| &&
|         <AddressID/>| &&
|         <CompanyCode/>| &&
|         <CompanyName/>| &&
|         <Country/>| &&
|         <EmailAddress>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</EmailAddress>| &&
|         <PhoneNumber>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</PhoneNumber>| &&
|      </Company>| &&
|      <CustomerProject>| &&
|         <CustomerProject/>| &&
|         <CustomerProjectName/>| &&
|         <EndDate/>| &&
|         <ProjectManagerName/>| &&
|         <StartDate/>| &&
|      </CustomerProject>| &&
|      <DownPaymentOverview>| &&
|         <DownPaymentGrossAmount>3.47</DownPaymentGrossAmount>| &&
|         <DownPaymentNetAmount>3.00</DownPaymentNetAmount>| &&
|         <DownPaymentRoundingDifferenceAmount>1.84</DownPaymentRoundingDifferenceAmount>| &&
|         <DownPaymentSettlementGrossAmount>7.89</DownPaymentSettlementGrossAmount>| &&
|         <DownPaymentSettlementNetAmount>7.10</DownPaymentSettlementNetAmount>| &&
|         <DownPaymentSettlementTaxAmount>0.63</DownPaymentSettlementTaxAmount>| &&
|         <DownPaymentTaxAmount>4.21</DownPaymentTaxAmount>| &&
|         <OpenTotalGrossAmount>1.42</OpenTotalGrossAmount>| &&
|         <OpenTotalTaxAmount>8.68</OpenTotalTaxAmount>| &&
|         <TransactionCurrency>Vale</TransactionCurrency>| &&
|         <DownPayments>| &&
|            <DownPaymentNode>| &&
|               <CreditAmount/>| &&
|               <DownPayment>Apros tres et quidem</DownPayment>| &&
|               <DownPaymentDueDate>20040606T101010</DownPaymentDueDate>| &&
|               <NetAmount>2.21</NetAmount>| &&
|               <TaxAmount>3.42</TaxAmount>| &&
|               <TotalAmount>4.63</TotalAmount>| &&
|               <TransactionCurrency>Mirum est</TransactionCurrency>| &&
|            </DownPaymentNode>| &&
|            <DownPaymentNode>| &&
|               <CreditAmount/>| &&
|               <DownPayment>Licebit auctore</DownPayment>| &&
|               <DownPaymentDueDate>20040606T101010</DownPaymentDueDate>| &&
|               <NetAmount>5.84</NetAmount>| &&
|               <TaxAmount>7.05</TaxAmount>| &&
|               <TotalAmount>8.26</TotalAmount>| &&
|               <TransactionCurrency>Proinde</TransactionCurrency>| &&
|            </DownPaymentNode>| &&
|            <DownPaymentNode>| &&
|               <CreditAmount/>| &&
|               <DownPayment>Am undique</DownPayment>| &&
|               <DownPaymentDueDate>20040606T101010</DownPaymentDueDate>| &&
|               <NetAmount>9.47</NetAmount>| &&
|               <TaxAmount>0.58</TaxAmount>| &&
|               <TotalAmount>1.79</TotalAmount>| &&
|               <TransactionCurrency>Ad retia sedebam</TransactionCurrency>| &&
|            </DownPaymentNode>| &&
|         </DownPayments>| &&
|      </DownPaymentOverview>| &&
|      <Incoterms>| &&
|         <Incoterms>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</Incoterms>| &&
|         <IncotermsLocation1>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</IncotermsLocation1>| &&
|         <IncotermsLocation1Lbl>Vale</IncotermsLocation1Lbl>| &&
|         <IncotermsLocation2>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</IncotermsLocation2>| &&
|         <IncotermsLocation2Lbl>Ego ille</IncotermsLocation2Lbl>| &&
|         <IncotermsVersion>Mirum est ut animus agitatione motuque corporis excitetut.</IncotermsVersion>| &&
|      </Incoterms>| &&
|      <Items>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Ad retia sedebam</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>Experieris non Dianam magis montibus quam Minervam inerare.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>4.19</NetAmount>| &&
|            <NetPriceAmount>5.40</NetPriceAmount>| &&
|            <NetPriceQuantity>6.61</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Si manu vacuas</PurchaseOrderByCustomer>| &&
|            <Quantity>2.98</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Mirum est ut animus agitatione motuque corporis excitetut.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Ego ille</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Apros tres et quidem</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Vale</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Mirum est</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Ego ille</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Mirum est ut animus agitatione motuque corporis excitetut.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Licebit auctore</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Proinde</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Am undique</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>7.82</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>0.14</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Mirum est</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>9.03</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Apros tres et quidem</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|                  <DocumentCurrency>Si manu vacuas</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>1.35</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>3.77</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Am undique</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>2.56</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Proinde</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionTypeName>| &&
|                  <DocumentCurrency>Licebit auctore</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>4.98</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>7.40</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ego ille</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>6.19</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Vale</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|                  <DocumentCurrency>Ad retia sedebam</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|               <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|               <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|               <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|               <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|               <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|               <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|               <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|               <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|               <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Experieris non Dianam magis montibus quam Minervam inerare.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Mirum est ut animus agitatione motuque corporis excitetut.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Mirum est</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Mirum est ut animus agitatione motuque corporis excitetut.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>Experieris non Dianam magis montibus quam Minervam inerare.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>3.35</NetAmount>| &&
|            <NetPriceAmount>4.56</NetPriceAmount>| &&
|            <NetPriceQuantity>5.77</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>Experieris non Dianam magis montibus quam Minervam inerare.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Am undique</PurchaseOrderByCustomer>| &&
|            <Quantity>2.14</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Proinde</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Mirum est ut animus agitatione motuque corporis excitetut.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Ad retia sedebam</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Licebit auctore</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>Experieris non Dianam magis montibus quam Minervam inerare.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Vale</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Proinde</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ego ille</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Si manu vacuas</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Experieris non Dianam magis montibus quam Minervam inerare.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Apros tres et quidem</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>6.98</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>9.40</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Vale</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>8.19</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ad retia sedebam</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Mirum est ut animus agitatione motuque corporis excitetut.</ConditionTypeName>| &&
|                  <DocumentCurrency>Am undique</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>0.51</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>2.93</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Apros tres et quidem</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>1.72</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Si manu vacuas</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ConditionTypeName>| &&
|                  <DocumentCurrency>Ego ille</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>4.14</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>6.56</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Proinde</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>5.35</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Licebit auctore</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</ConditionTypeName>| &&
|                  <DocumentCurrency>Mirum est</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressID>| &&
|               <AddressLine1Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine1Text>| &&
|               <AddressLine2Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine2Text>| &&
|               <AddressLine3Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine3Text>| &&
|               <AddressLine4Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine4Text>| &&
|               <AddressLine5Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine5Text>| &&
|               <AddressLine6Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine6Text>| &&
|               <AddressLine7Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine7Text>| &&
|               <AddressLine8Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine8Text>| &&
|               <AddressType>Mirum est ut animus agitatione motuque corporis excitetut.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Mirum est ut animus agitatione motuque corporis excitetut.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Experieris non Dianam magis montibus quam Minervam inerare.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Vale</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>Experieris non Dianam magis montibus quam Minervam inerare.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>2.51</NetAmount>| &&
|            <NetPriceAmount>3.72</NetPriceAmount>| &&
|            <NetPriceQuantity>4.93</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Apros tres et quidem</PurchaseOrderByCustomer>| &&
|            <Quantity>1.30</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Mirum est ut animus agitatione motuque corporis excitetut.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Si manu vacuas</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Mirum est</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Ego ille</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Licebit auctore</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Si manu vacuas</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Mirum est ut animus agitatione motuque corporis excitetut.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Proinde</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Am undique</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ad retia sedebam</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>6.14</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>8.56</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Licebit auctore</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>7.35</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Mirum est</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|                  <DocumentCurrency>Apros tres et quidem</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>9.77</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>2.09</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ad retia sedebam</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>0.88</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Am undique</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionTypeName>| &&
|                  <DocumentCurrency>Proinde</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>3.30</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>5.72</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Si manu vacuas</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>4.51</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ego ille</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|                  <DocumentCurrency>Vale</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|               <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|               <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|               <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|               <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|               <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|               <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|               <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|               <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|               <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Experieris non Dianam magis montibus quam Minervam inerare.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Mirum est ut animus agitatione motuque corporis excitetut.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Licebit auctore</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Mirum est ut animus agitatione motuque corporis excitetut.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>Experieris non Dianam magis montibus quam Minervam inerare.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>1.67</NetAmount>| &&
|            <NetPriceAmount>2.88</NetPriceAmount>| &&
|            <NetPriceQuantity>4.09</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>Experieris non Dianam magis montibus quam Minervam inerare.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Ad retia sedebam</PurchaseOrderByCustomer>| &&
|            <Quantity>0.46</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Am undique</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Mirum est ut animus agitatione motuque corporis excitetut.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Vale</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Proinde</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>Experieris non Dianam magis montibus quam Minervam inerare.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Ego ille</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Am undique</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Si manu vacuas</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Apros tres et quidem</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Experieris non Dianam magis montibus quam Minervam inerare.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Mirum est</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>5.30</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>7.72</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ego ille</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>6.51</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Vale</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Mirum est ut animus agitatione motuque corporis excitetut.</ConditionTypeName>| &&
|                  <DocumentCurrency>Ad retia sedebam</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>8.93</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>1.25</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Mirum est</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>0.04</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Apros tres et quidem</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ConditionTypeName>| &&
|                  <DocumentCurrency>Si manu vacuas</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>2.46</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>4.88</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Am undique</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>3.67</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Proinde</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</ConditionTypeName>| &&
|                  <DocumentCurrency>Licebit auctore</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressID>| &&
|               <AddressLine1Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine1Text>| &&
|               <AddressLine2Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine2Text>| &&
|               <AddressLine3Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine3Text>| &&
|               <AddressLine4Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine4Text>| &&
|               <AddressLine5Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine5Text>| &&
|               <AddressLine6Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine6Text>| &&
|               <AddressLine7Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine7Text>| &&
|               <AddressLine8Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine8Text>| &&
|               <AddressType>Mirum est ut animus agitatione motuque corporis excitetut.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Mirum est ut animus agitatione motuque corporis excitetut.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Experieris non Dianam magis montibus quam Minervam inerare.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Ego ille</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>Experieris non Dianam magis montibus quam Minervam inerare.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>0.83</NetAmount>| &&
|            <NetPriceAmount>2.04</NetPriceAmount>| &&
|            <NetPriceQuantity>3.25</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Mirum est</PurchaseOrderByCustomer>| &&
|            <Quantity>9.72</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Mirum est ut animus agitatione motuque corporis excitetut.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Apros tres et quidem</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Licebit auctore</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Si manu vacuas</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Proinde</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Apros tres et quidem</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Mirum est ut animus agitatione motuque corporis excitetut.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Am undique</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ad retia sedebam</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Vale</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>4.46</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>6.88</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Proinde</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>5.67</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Licebit auctore</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|                  <DocumentCurrency>Mirum est</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>8.09</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>0.41</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Vale</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>9.30</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ad retia sedebam</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionTypeName>| &&
|                  <DocumentCurrency>Am undique</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>1.62</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>4.04</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Apros tres et quidem</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>2.83</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Si manu vacuas</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|                  <DocumentCurrency>Ego ille</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|               <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|               <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|               <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|               <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|               <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|               <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|               <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|               <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|               <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Experieris non Dianam magis montibus quam Minervam inerare.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Mirum est ut animus agitatione motuque corporis excitetut.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Proinde</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Mirum est ut animus agitatione motuque corporis excitetut.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>Experieris non Dianam magis montibus quam Minervam inerare.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>10.09</NetAmount>| &&
|            <NetPriceAmount>1.20</NetPriceAmount>| &&
|            <NetPriceQuantity>2.41</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>Experieris non Dianam magis montibus quam Minervam inerare.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Vale</PurchaseOrderByCustomer>| &&
|            <Quantity>8.88</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Ad retia sedebam</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Mirum est ut animus agitatione motuque corporis excitetut.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Ego ille</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Am undique</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>Experieris non Dianam magis montibus quam Minervam inerare.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Si manu vacuas</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Ad retia sedebam</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Apros tres et quidem</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Mirum est</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Experieris non Dianam magis montibus quam Minervam inerare.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Licebit auctore</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>3.62</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>6.04</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Si manu vacuas</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>4.83</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ego ille</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Mirum est ut animus agitatione motuque corporis excitetut.</ConditionTypeName>| &&
|                  <DocumentCurrency>Vale</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>7.25</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>9.67</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Licebit auctore</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>8.46</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Mirum est</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ConditionTypeName>| &&
|                  <DocumentCurrency>Apros tres et quidem</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>0.78</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>3.20</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ad retia sedebam</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>1.99</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Am undique</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</ConditionTypeName>| &&
|                  <DocumentCurrency>Proinde</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressID>| &&
|               <AddressLine1Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine1Text>| &&
|               <AddressLine2Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine2Text>| &&
|               <AddressLine3Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine3Text>| &&
|               <AddressLine4Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine4Text>| &&
|               <AddressLine5Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine5Text>| &&
|               <AddressLine6Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine6Text>| &&
|               <AddressLine7Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine7Text>| &&
|               <AddressLine8Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine8Text>| &&
|               <AddressType>Mirum est ut animus agitatione motuque corporis excitetut.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Mirum est ut animus agitatione motuque corporis excitetut.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Experieris non Dianam magis montibus quam Minervam inerare.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Si manu vacuas</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>Experieris non Dianam magis montibus quam Minervam inerare.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>9.25</NetAmount>| &&
|            <NetPriceAmount>0.36</NetPriceAmount>| &&
|            <NetPriceQuantity>1.57</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Licebit auctore</PurchaseOrderByCustomer>| &&
|            <Quantity>8.04</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Mirum est ut animus agitatione motuque corporis excitetut.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Mirum est</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Proinde</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Apros tres et quidem</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Am undique</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Mirum est</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Mirum est ut animus agitatione motuque corporis excitetut.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ad retia sedebam</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Vale</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ego ille</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>2.78</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>5.20</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Am undique</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>3.99</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Proinde</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|                  <DocumentCurrency>Licebit auctore</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>6.41</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>8.83</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ego ille</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>7.62</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Vale</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionTypeName>| &&
|                  <DocumentCurrency>Ad retia sedebam</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>10.04</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>2.36</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Mirum est</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>1.15</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Apros tres et quidem</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|                  <DocumentCurrency>Si manu vacuas</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|               <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|               <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|               <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|               <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|               <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|               <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|               <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|               <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|               <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Experieris non Dianam magis montibus quam Minervam inerare.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Mirum est ut animus agitatione motuque corporis excitetut.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Am undique</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Mirum est ut animus agitatione motuque corporis excitetut.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>Experieris non Dianam magis montibus quam Minervam inerare.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>8.41</NetAmount>| &&
|            <NetPriceAmount>9.62</NetPriceAmount>| &&
|            <NetPriceQuantity>0.73</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>Experieris non Dianam magis montibus quam Minervam inerare.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Ego ille</PurchaseOrderByCustomer>| &&
|            <Quantity>7.20</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Vale</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Mirum est ut animus agitatione motuque corporis excitetut.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Si manu vacuas</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Ad retia sedebam</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>Experieris non Dianam magis montibus quam Minervam inerare.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Apros tres et quidem</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Vale</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Mirum est</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Licebit auctore</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Experieris non Dianam magis montibus quam Minervam inerare.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Proinde</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>1.94</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>4.36</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Apros tres et quidem</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>3.15</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Si manu vacuas</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Mirum est ut animus agitatione motuque corporis excitetut.</ConditionTypeName>| &&
|                  <DocumentCurrency>Ego ille</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>5.57</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>7.99</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Proinde</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>6.78</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Licebit auctore</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ConditionTypeName>| &&
|                  <DocumentCurrency>Mirum est</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>9.20</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>1.52</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Vale</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>0.31</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ad retia sedebam</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</ConditionTypeName>| &&
|                  <DocumentCurrency>Am undique</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressID>| &&
|               <AddressLine1Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine1Text>| &&
|               <AddressLine2Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine2Text>| &&
|               <AddressLine3Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine3Text>| &&
|               <AddressLine4Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine4Text>| &&
|               <AddressLine5Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine5Text>| &&
|               <AddressLine6Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine6Text>| &&
|               <AddressLine7Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine7Text>| &&
|               <AddressLine8Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine8Text>| &&
|               <AddressType>Mirum est ut animus agitatione motuque corporis excitetut.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Mirum est ut animus agitatione motuque corporis excitetut.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Experieris non Dianam magis montibus quam Minervam inerare.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|         <BillingDocumentItemNode>| &&
|            <Batch>Apros tres et quidem</Batch>| &&
|            <BatchItemBillingVariant/>| &&
|            <BillingDocumentItem>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</BillingDocumentItem>| &&
|            <BillingDocumentItemText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</BillingDocumentItemText>| &&
|            <BillingPeriodOfPerfEndDate/>| &&
|            <BillingPeriodOfPerfStartDate/>| &&
|            <CommodityCode/>| &&
|            <CountryOfOrigin/>| &&
|            <GrossAmount/>| &&
|            <HigherLevelItem>Experieris non Dianam magis montibus quam Minervam inerare.</HigherLevelItem>| &&
|            <HigherLvlItmOfBatSpItm/>| &&
|            <ItemNetWeight/>| &&
|            <ItemWeightUnit/>| &&
|            <Material>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Material>| &&
|            <MaterialIsInternalBatchManaged/>| &&
|            <MaterialName/>| &&
|            <NetAmount>7.57</NetAmount>| &&
|            <NetPriceAmount>8.78</NetPriceAmount>| &&
|            <NetPriceQuantity>9.99</NetPriceQuantity>| &&
|            <NetPriceQuantityUnit/>| &&
|            <NetPriceQuantityUnitTechName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</NetPriceQuantityUnitTechName>| &&
|            <PurchaseOrderByCustomer>Proinde</PurchaseOrderByCustomer>| &&
|            <Quantity>6.36</Quantity>| &&
|            <QuantityUnit/>| &&
|            <QuantityUnitTechName>Mirum est ut animus agitatione motuque corporis excitetut.</QuantityUnitTechName>| &&
|            <ReferenceSDDocument>Licebit auctore</ReferenceSDDocument>| &&
|            <ReferenceSDDocumentCategory/>| &&
|            <ReferenceSDDocumentCategoryName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ReferenceSDDocumentCategoryName>| &&
|            <ReferenceSDDocumentItem/>| &&
|            <RegionOfOrigin/>| &&
|            <SalesContract>Am undique</SalesContract>| &&
|            <SalesContractItem/>| &&
|            <SalesDocument>Mirum est</SalesDocument>| &&
|            <SalesDocumentItem/>| &&
|            <SalesOrderExternalDocumentId/>| &&
|            <SalesSDDocumentCategory/>| &&
|            <SalesSDDocumentCategoryName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</SalesSDDocumentCategoryName>| &&
|            <ServicesRenderedDate/>| &&
|            <SoldProduct/>| &&
|            <SolutionOrder>Ad retia sedebam</SolutionOrder>| &&
|            <SolutionOrderItem/>| &&
|            <StatisticalValue>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</StatisticalValue>| &&
|            <TaxAmount/>| &&
|            <TimesheetOvertimeCategory/>| &&
|            <TimesheetOvertimeCategoryText/>| &&
|            <TransactionCurrency>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TransactionCurrency>| &&
|            <YY1_CustomerMaterial_BDI>Licebit auctore</YY1_CustomerMaterial_BDI>| &&
|            <YY1_CustomerMaterial_BDIF/>| &&
|            <ItemBatchDetails>| &&
|               <ItemBatchDetailsNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription/>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription/>| &&
|               </ItemBatchDetailsNode>| &&
|            </ItemBatchDetails>| &&
|            <ItemConfiguration>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Mirum est ut animus agitatione motuque corporis excitetut.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Vale</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Ego ille</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|               <ItemConfigurationNode>| &&
|                  <Characteristic/>| &&
|                  <CharacteristicDescription>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</CharacteristicDescription>| &&
|                  <CharacteristicValue/>| &&
|                  <CharacteristicValueDescription>Si manu vacuas</CharacteristicValueDescription>| &&
|               </ItemConfigurationNode>| &&
|            </ItemConfiguration>| &&
|            <ItemPricingConditions>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>1.10</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>3.52</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Ad retia sedebam</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>2.31</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Am undique</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|                  <DocumentCurrency>Proinde</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>4.73</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>7.15</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Si manu vacuas</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>5.94</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Ego ille</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionTypeName>| &&
|                  <DocumentCurrency>Vale</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|               <ItemPricingConditionNode>| &&
|                  <ConditionAmount>8.36</ConditionAmount>| &&
|                  <ConditionBaseValue/>| &&
|                  <ConditionBaseValueUnit/>| &&
|                  <ConditionQuantity>0.68</ConditionQuantity>| &&
|                  <ConditionQuantityUnit/>| &&
|                  <ConditionQuantityUnitTechName>Licebit auctore</ConditionQuantityUnitTechName>| &&
|                  <ConditionRateValue>9.57</ConditionRateValue>| &&
|                  <ConditionRateValueUnit>Mirum est</ConditionRateValueUnit>| &&
|                  <ConditionStep/>| &&
|                  <ConditionType/>| &&
|                  <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|                  <DocumentCurrency>Apros tres et quidem</DocumentCurrency>| &&
|                  <VariantCondition/>| &&
|               </ItemPricingConditionNode>| &&
|            </ItemPricingConditions>| &&
|            <ItemSerialNUmber>| &&
|               <SerialNumberNode>| &&
|                  <SerialNumber/>| &&
|               </SerialNumberNode>| &&
|            </ItemSerialNUmber>| &&
|            <ItemShipToParty>| &&
|               <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|               <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|               <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|               <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|               <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|               <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|               <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|               <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|               <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|               <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|               <FullName/>| &&
|               <Partner/>| &&
|               <PartnerFunction/>| &&
|               <PartnerFunctionName/>| &&
|               <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|            </ItemShipToParty>| &&
|            <ItemTextElements>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Experieris non Dianam magis montibus quam Minervam inerare.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>Mirum est ut animus agitatione motuque corporis excitetut.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|               <ItemTextElementNode>| &&
|                  <Language/>| &&
|                  <TextElement>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElement>| &&
|                  <TextElementDescription/>| &&
|                  <TextElementText>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElementText>| &&
|               </ItemTextElementNode>| &&
|            </ItemTextElements>| &&
|         </BillingDocumentItemNode>| &&
|      </Items>| &&
|      <LegallyRequiredTexts>| &&
|         <LegallyRequiredTextNode>| &&
|            <LegallyRequiredText>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</LegallyRequiredText>| &&
|            <TaxCode/>| &&
|         </LegallyRequiredTextNode>| &&
|         <LegallyRequiredTextNode>| &&
|            <LegallyRequiredText>Experieris non Dianam magis montibus quam Minervam inerare.</LegallyRequiredText>| &&
|            <TaxCode/>| &&
|         </LegallyRequiredTextNode>| &&
|         <LegallyRequiredTextNode>| &&
|            <LegallyRequiredText>Mirum est ut animus agitatione motuque corporis excitetut.</LegallyRequiredText>| &&
|            <TaxCode/>| &&
|         </LegallyRequiredTextNode>| &&
|      </LegallyRequiredTexts>| &&
|      <PayerParty>| &&
|         <AddressID>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressID>| &&
|         <AddressLine1Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine1Text>| &&
|         <AddressLine2Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine2Text>| &&
|         <AddressLine3Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine3Text>| &&
|         <AddressLine4Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine4Text>| &&
|         <AddressLine5Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine5Text>| &&
|         <AddressLine6Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine6Text>| &&
|         <AddressLine7Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine7Text>| &&
|         <AddressLine8Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine8Text>| &&
|         <AddressType>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressType>| &&
|         <FullName/>| &&
|         <Partner/>| &&
|         <PartnerFunction/>| &&
|         <PartnerFunctionName/>| &&
|         <Person>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</Person>| &&
|      </PayerParty>| &&
|      <PaymentCard>| &&
|         <PaymentCardNode>| &&
|            <BillingDocument/>| &&
|            <Currency>Ego ille</Currency>| &&
|            <PaymentCardBillingAmount>6.63</PaymentCardBillingAmount>| &&
|            <PaymentCardMaskedNumber>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</PaymentCardMaskedNumber>| &&
|            <PaymentCardTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</PaymentCardTypeName>| &&
|            <PaymentServiceProvider>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</PaymentServiceProvider>| &&
|         </PaymentCardNode>| &&
|         <PaymentCardNode>| &&
|            <BillingDocument/>| &&
|            <Currency>Si manu vacuas</Currency>| &&
|            <PaymentCardBillingAmount>7.84</PaymentCardBillingAmount>| &&
|            <PaymentCardMaskedNumber>Mirum est ut animus agitatione motuque corporis excitetut.</PaymentCardMaskedNumber>| &&
|            <PaymentCardTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</PaymentCardTypeName>| &&
|            <PaymentServiceProvider>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</PaymentServiceProvider>| &&
|         </PaymentCardNode>| &&
|         <PaymentCardNode>| &&
|            <BillingDocument/>| &&
|            <Currency>Apros tres et quidem</Currency>| &&
|            <PaymentCardBillingAmount>9.05</PaymentCardBillingAmount>| &&
|            <PaymentCardMaskedNumber>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</PaymentCardMaskedNumber>| &&
|            <PaymentCardTypeName>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</PaymentCardTypeName>| &&
|            <PaymentServiceProvider>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</PaymentServiceProvider>| &&
|         </PaymentCardNode>| &&
|      </PaymentCard>| &&
|      <PaymentMethod>| &&
|         <PaymentMethod/>| &&
|         <PaymentMethodName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</PaymentMethodName>| &&
|      </PaymentMethod>| &&
|      <PaymentRequest>| &&
|         <PaymentRequestNode>| &&
|            <DigitalPaymentPaymentRequest/>| &&
|            <PaymentRequestCheckoutURL/>| &&
|         </PaymentRequestNode>| &&
|      </PaymentRequest>| &&
|      <PaymentTerms>| &&
|         <PaymentDueDate/>| &&
|         <PaymentTerm1Description>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</PaymentTerm1Description>| &&
|         <PaymentTerm2Description>Experieris non Dianam magis montibus quam Minervam inerare.</PaymentTerm2Description>| &&
|         <PaymentTerm3Description>Mirum est ut animus agitatione motuque corporis excitetut.</PaymentTerm3Description>| &&
|         <PaymentTermsName>Si manu vacuas</PaymentTermsName>| &&
|      </PaymentTerms>| &&
|      <PricingConditions>| &&
|         <PricingConditionNode>| &&
|            <ConditionAmount>3.89</ConditionAmount>| &&
|            <ConditionBaseValue/>| &&
|            <ConditionBaseValueUnit/>| &&
|            <ConditionQuantity/>| &&
|            <ConditionQuantityUnit/>| &&
|            <ConditionQuantityUnitTechName/>| &&
|            <ConditionRateValue>2.68</ConditionRateValue>| &&
|            <ConditionRateValueUnit>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</ConditionRateValueUnit>| &&
|            <ConditionStep/>| &&
|            <ConditionType>Ego ille</ConditionType>| &&
|            <ConditionTypeName>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</ConditionTypeName>| &&
|            <DocumentCurrency>Vale</DocumentCurrency>| &&
|         </PricingConditionNode>| &&
|         <PricingConditionNode>| &&
|            <ConditionAmount>6.31</ConditionAmount>| &&
|            <ConditionBaseValue/>| &&
|            <ConditionBaseValueUnit/>| &&
|            <ConditionQuantity/>| &&
|            <ConditionQuantityUnit/>| &&
|            <ConditionQuantityUnitTechName/>| &&
|            <ConditionRateValue>5.10</ConditionRateValue>| &&
|            <ConditionRateValueUnit>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</ConditionRateValueUnit>| &&
|            <ConditionStep/>| &&
|            <ConditionType>Apros tres et quidem</ConditionType>| &&
|            <ConditionTypeName>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</ConditionTypeName>| &&
|            <DocumentCurrency>Si manu vacuas</DocumentCurrency>| &&
|         </PricingConditionNode>| &&
|         <PricingConditionNode>| &&
|            <ConditionAmount>8.73</ConditionAmount>| &&
|            <ConditionBaseValue/>| &&
|            <ConditionBaseValueUnit/>| &&
|            <ConditionQuantity/>| &&
|            <ConditionQuantityUnit/>| &&
|            <ConditionQuantityUnitTechName/>| &&
|            <ConditionRateValue>7.52</ConditionRateValue>| &&
|            <ConditionRateValueUnit>Mirum est ut animus agitatione motuque corporis excitetut.</ConditionRateValueUnit>| &&
|            <ConditionStep/>| &&
|            <ConditionType>Licebit auctore</ConditionType>| &&
|            <ConditionTypeName>Experieris non Dianam magis montibus quam Minervam inerare.</ConditionTypeName>| &&
|            <DocumentCurrency>Mirum est</DocumentCurrency>| &&
|         </PricingConditionNode>| &&
|      </PricingConditions>| &&
|      <PricingTerms>| &&
|         <DeliveryDate>20040606T101010</DeliveryDate>| &&
|         <PricingDate/>| &&
|      </PricingTerms>| &&
|      <SEPA>| &&
|         <BICNumber/>| &&
|         <BankName>Ego ille</BankName>| &&
|         <IBAN>Vale</IBAN>| &&
|         <PaymentDueDate>20040606T101010</PaymentDueDate>| &&
|         <SEPAMandate>Experieris non Dianam magis montibu</SEPAMandate>| &&
|      </SEPA>| &&
|      <ShipToParty>| &&
|         <AddressID>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressID>| &&
|         <AddressLine1Text>Ego ille</AddressLine1Text>| &&
|         <AddressLine2Text>Si manu vacuas</AddressLine2Text>| &&
|         <AddressLine3Text>Apros tres et quidem</AddressLine3Text>| &&
|         <AddressLine4Text>Mirum est</AddressLine4Text>| &&
|         <AddressLine5Text>Licebit auctore</AddressLine5Text>| &&
|         <AddressLine6Text>Proinde</AddressLine6Text>| &&
|         <AddressLine7Text>Am undique</AddressLine7Text>| &&
|         <AddressLine8Text>Ad retia sedebam</AddressLine8Text>| &&
|         <AddressType>Mirum est ut animus agitatione motuque corporis excitetut.</AddressType>| &&
|         <FullName/>| &&
|         <Partner/>| &&
|         <PartnerFunction/>| &&
|         <PartnerFunctionName/>| &&
|         <Person>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Person>| &&
|      </ShipToParty>| &&
|      <SoldToParty>| &&
|         <AddressID>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressID>| &&
|         <AddressLine1Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine1Text>| &&
|         <AddressLine2Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine2Text>| &&
|         <AddressLine3Text>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</AddressLine3Text>| &&
|         <AddressLine4Text>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressLine4Text>| &&
|         <AddressLine5Text>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</AddressLine5Text>| &&
|         <AddressLine6Text>Experieris non Dianam magis montibus quam Minervam inerare.</AddressLine6Text>| &&
|         <AddressLine7Text>Mirum est ut animus agitatione motuque corporis excitetut.</AddressLine7Text>| &&
|         <AddressLine8Text>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</AddressLine8Text>| &&
|         <AddressType>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</AddressType>| &&
|         <FullName/>| &&
|         <Partner/>| &&
|         <PartnerFunction/>| &&
|         <PartnerFunctionName/>| &&
|         <Person>Experieris non Dianam magis montibus quam Minervam inerare.</Person>| &&
|      </SoldToParty>| &&
|      <TaxationTerms>| &&
|         <CompanyVATRegistration>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</CompanyVATRegistration>| &&
|         <CustomerVATRegistration>Experieris non Dianam magis montibus quam Minervam inerare.</CustomerVATRegistration>| &&
|         <TaxDepartureCountry/>| &&
|         <VATRegistrationCountryName/>| &&
|         <VATRegistrationOrigin/>| &&
|         <VATRegistrationOriginName/>| &&
|      </TaxationTerms>| &&
|      <TextElements>| &&
|         <TextElementNode>| &&
|            <Language/>| &&
|            <TextElement>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</TextElement>| &&
|            <TextElementDescription/>| &&
|            <TextElementText>Ad retia sedebam: erat in proximo non venabulum aut lancea, sed stilus et pugilares:</TextElementText>| &&
|         </TextElementNode>| &&
|         <TextElementNode>| &&
|            <Language/>| &&
|            <TextElement>Proinde cum venabere, licebit, auctore me, ut panarium et lagunculam sic etiam pugillares feras.</TextElement>| &&
|            <TextElementDescription/>| &&
|            <TextElementText>Iam undique silvae et solitudo ipsumque illud silentium quod venationi datur magna cogitationis incitamenta sunt.</TextElementText>| &&
|         </TextElementNode>| &&
|         <TextElementNode>| &&
|            <Language/>| &&
|            <TextElement>Mirum est ut animus agitatione motuque corporis excitetut.</TextElement>| &&
|            <TextElementDescription/>| &&
|            <TextElementText>Experieris non Dianam magis montibus quam Minervam inerare.</TextElementText>| &&
|         </TextElementNode>| &&
|      </TextElements>| &&
|      <VATSummary>| &&
|         <VATSummaryNode>| &&
|            <CndnAmountInCocodeCrcy/>| &&
|            <CndnAmountInCountryCrcy/>| &&
|            <CndnBaseAmountInCountryCrcy/>| &&
|            <CndnBaseamountInCocodeCrcy/>| &&
|            <CompanyCodeCurrency/>| &&
|            <ConditionAmount/>| &&
|            <ConditionBaseValue/>| &&
|            <ConditionBaseValueUnit/>| &&
|            <ConditionRateValue/>| &&
|            <ConditionRateValueUnit/>| &&
|            <CountryCurrency/>| &&
|            <DocumentCurrency/>| &&
|            <TargetTaxCode/>| &&
|            <TaxCode/>| &&
|            <TaxCodeName/>| &&
|         </VATSummaryNode>| &&
|      </VATSummary>| &&
|   </BillingDocumentNode>| &&
|</Form>| .




    TRY.
*Render PDF
        cl_fp_ads_util=>render_pdf( EXPORTING iv_xml_data      = lv_xml_data
                                              iv_xdp_layout    = lv_xdp
                                              iv_locale        = 'en_US'
                                              is_options       = ls_options
                                    IMPORTING ev_pdf           = ev_pdf
                                              ev_pages         = ev_pages
                                              ev_trace_string  = ev_trace_string
                                              ).

      CATCH cx_fp_ads_util INTO DATA(lx_fp_ads_util).
        out->write( lx_fp_ads_util->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

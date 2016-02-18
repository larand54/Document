procedure TfrmInvoiceList.EmailFakturaAndSpecExecute(const InternalInvoiceNo
  : Integer);
const
  LF = #10;
Var
  FormCRExportOneReport: TFormCRExportOneReport;
  A: array of variant;
  dm_SendMapiMail: Tdm_SendMapiMail;
  Attach: array of String;
  MailToAddressAgent, MailToAddressKund, MailToAddress: String;
  RC: TCMReportController;
  DocTyp, RoleType, ClientNo: Integer;
  Params: TCMParams;
  ExportInvoiceFile: string;
  ExportSpecFile: string;
begin
  if dmVidaInvoice.cdsInvoiceList.Locate('InternalInvoiceNo', InternalInvoiceNo,
    []) then Begin

    { if (not dmVidaInvoice.cdsInvoiceListAgentNo.IsNull) and
      (dmVidaInvoice.cdsInvoiceListAgentNo.AsInteger > 0) then
      MailToAddress:= dmsContact.GetEmailAddress(dmVidaInvoice.cdsInvoiceListAgentNo.AsInteger)
      else
      MailToAddress:= dmsContact.GetEmailAddress(dmVidaInvoice.cdsInvoiceListCustomerNo.AsInteger) ; }

    if (not dmVidaInvoice.cdsInvoiceListAgentNo.IsNull) and
      (dmVidaInvoice.cdsInvoiceListAgentNo.AsInteger > 0) then
      MailToAddressAgent := dmsContact.GetEmailAddress
        (dmVidaInvoice.cdsInvoiceListAgentNo.AsInteger);

    MailToAddressKund := dmsContact.GetEmailAddress
      (dmVidaInvoice.cdsInvoiceListCustomerNo.AsInteger);

    if (Length(MailToAddressAgent) > 0) and (Length(MailToAddressKund) > 0) then
      MailToAddress := MailToAddressAgent + MailToAddressKund
    else if (Length(MailToAddressAgent) > 0) then
      MailToAddress := MailToAddressAgent
    else if (Length(MailToAddressKund) > 0) then
      MailToAddress := MailToAddressKund;

    if Length(MailToAddress) = 0 then Begin
      MailToAddress := 'ange@adress.nu';
      ShowMessage
        ('Email address is missing for the client.');
    End;
    if Length(MailToAddress) > 0 then Begin

      if dmVidaInvoice.cdsInvoiceListInternalInvoiceNo.AsInteger < 1 then
        Exit;
      ExportInvoiceFile := ExcelDir + 'InvoiceNo ' +
        dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString + '.pdf';
      ExportSpecFile := ExcelDir + 'Specification ' +
        dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString + '.pdf';
      ClientNo := dmVidaInvoice.cdsInvoiceListCustomerNo.AsInteger;

      if uReportController.useFR then begin

        Params := TCMParams.Create();
        Params.Add('@INVOICENO', dmVidaInvoice.cdsInvoiceHeadInternalInvoiceNo.
          AsInteger);

        RC := TCMReportController.Create;
        RoleType := -1;

        Try
          RC.setExportFile(ExportInvoiceFile);
          RC.RunReport(0, ClientNo, RoleType, cFaktura, Params, frFile);
          RC.setExportFile(ExportSpecFile);
          RC.RunReport(0, ClientNo, RoleType, cPkgSpec, Params, frFile);
        Finally
          FreeAndNil(Params);
          FreeAndNil(RC);
        End;
        if not(FileExists(ExportInvoiceFile) and FileExists(ExportSpecFile))
        then begin
          ShowMessage('Report file were not created.');
          Exit;
        end;
      end
      else begin
        FormCRExportOneReport := TFormCRExportOneReport.Create(Nil);
        Try
          SetLength(A, 1);
          A[0] := dmVidaInvoice.cdsInvoiceListInternalInvoiceNo.AsInteger;
          FormCRExportOneReport.CreateCo(ClientNo, cFaktura, A,
            ExcelDir + 'InvoiceNo ' +
            dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString);
          FormCRExportOneReport.CreateCo(ClientNo, cPkgSpec, A,
            ExcelDir + 'Specification ' +
            dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString);
        Finally
          FreeAndNil(FormCRExportOneReport); // .Free ;
        End;
      end;

      SetLength(Attach, 2);
      Attach[0] := ExportInvoiceFile;
      Attach[1] := ExportSpecFile;
      dm_SendMapiMail := Tdm_SendMapiMail.Create(nil);
      Try
        dm_SendMapiMail.SendMail('Faktura/specifikation. Fakturanr: ' +
          dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString +
          ' - Invoice/package specification. InvoiceNo: ' +
          dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString,
          'Faktura och paketspecifikation bifogad. ' + LF + '' +
          'Invoice and package specification attached. ' + LF + '' + LF + '' +
          LF + 'MVH/Best Regards, ' + LF + '' + dmsContact.GetFirstAndLastName
          (thisuser.userid), dmsSystem.Get_Dir('MyEmailAddress'), MailToAddress,
          Attach, False);
        dmVidaInvoice.MailaCopyToVIDASTORE
          (dmVidaInvoice.cdsInvoiceListINVOICE_NO.AsString,
          dmVidaInvoice.cdsInvoiceListInternalInvoiceNo.AsInteger,
          dmVidaInvoice.cdsInvoiceListCustomerNo.AsInteger);
      Finally
        FreeAndNil(dm_SendMapiMail);
      End;
    End
    else
      ShowMessage('Email address is missing for the client.');
  End; // if dmVidaInvoice.cdsInvoiceList.Locate('InternalInvoiceNo', InternalInvoiceNo, []) then
end;

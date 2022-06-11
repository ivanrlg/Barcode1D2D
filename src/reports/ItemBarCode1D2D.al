report 80100 ItemBarCode1D2D
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultRenderingLayout = "src\reports\ItemBarcodes.docx";
    Caption = 'Item Barcodes';
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }

            column(Unit_Price; "Unit Price")
            {
            }
            column(BardcodeQRCode1D; Code39_1D)
            {
            }
            column(BardcodeQRCode2D; QRCode_2D)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Generate_Bardcode_Code39_1D();
                Generate_Bardcode_QRCode_2D();
            end;
        }
    }

    rendering
    {
        layout("src\reports\ItemBarcodes.docx")
        {
            Type = Word;
            LayoutFile = 'src\reports\ItemBarcodes.docx';
        }
    }

    local procedure Generate_Bardcode_Code39_1D()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
    begin
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
        BarcodeString := Item."No.";
        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
        Code39_1D := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
    end;

    local procedure Generate_Bardcode_QRCode_2D()
    var
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        BarcodeString: Text;
    begin
        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
        BarcodeString := Item."No.";
        QRCode_2D := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
    end;


    var
        Code39_1D: Text;
        QRCode_2D: Text;
}

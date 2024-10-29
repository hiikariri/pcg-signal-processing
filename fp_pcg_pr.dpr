program fp_pcg_pr;

uses
  Forms,
  fp_pcg in 'fp_pcg.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

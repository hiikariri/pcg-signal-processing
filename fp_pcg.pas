unit fp_pcg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    open_dialog: TOpenDialog;
    cht1: TChart;
    btn3: TBitBtn;
    btn4: TBitBtn;
    btn5: TBitBtn;
    cht2: TChart;
    cht3: TChart;
    Series3: TLineSeries;
    cht4: TChart;
    Series4: TLineSeries;
    Series2: TLineSeries;
    cht5: TChart;
    Series5: TLineSeries;
    btn6: TBitBtn;
    cht6: TChart;
    Series6: TLineSeries;
    cht7: TChart;
    Series7: TLineSeries;
    btn7: TBitBtn;
    Series1: TLineSeries;
    lbledt1: TLabeledEdit;
    lbledt2: TLabeledEdit;
    lbledt3: TLabeledEdit;
    lst1: TListBox;
    Series9: TLineSeries;
    Series8: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    lst3: TListBox;
    lbledt4: TLabeledEdit;
    lbledt5: TLabeledEdit;
    Series13: TLineSeries;
    Series14: TLineSeries;
    cht8: TChart;
    Series15: TLineSeries;
    Series16: TLineSeries;
    Series17: TLineSeries;
    btn8: TBitBtn;
    lst5: TListBox;
    lst6: TListBox;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  data_input, band_pass_result, abs_result, mav_result, backward_mav_result, threshold_result_s1, threshold_result_s2 : array[0..100000] of Double;
  rising_edge_time, falling_edge_time, rising_edge_time_s2, falling_edge_time_s2 : array of Double;
  data_size : Integer;
  sampling_freq, time_sampling, filter_order, threshold_s1, threshold_s2 : Double;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  filename, line: string;
  file_data: TextFile;
  sequence : Integer;
  data1, data2, data_pcg: Double;
begin
  sampling_freq := 1000;
  time_sampling := 1/sampling_freq;
  sequence := 0;

  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  Series6.Clear;
  Series7.Clear;
  Series8.Clear;
  Series9.Clear;
  Series10.Clear;

  lst1.Clear;

  data_size := 0;
  if open_dialog.Execute then
  begin
    filename := open_dialog.FileName;
    AssignFile(file_data, filename);
    Reset(file_data);

    while not Eof(file_data) do
    begin
      ReadLn(file_data, line);
      ReadLn(file_data, sequence, data1, data2, data_pcg);
      Series1.AddXY(sequence/sampling_freq, data_pcg);
      data_input[sequence] := data_pcg;
    end;
    data_size := sequence;
    CloseFile(file_data);
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  low_cutoff_freq, high_cutoff_freq, low_ohm, high_ohm, a, b : Double;
  i, n : Integer;
begin
  Series2.Clear;
  low_cutoff_freq := StrToFloat(lbledt1.Text);
  high_cutoff_freq := StrToFloat(lbledt2.Text);

  low_ohm := 2 * Pi * low_cutoff_freq;
  high_ohm := 2 * Pi * high_cutoff_freq;

  a := 2 * time_sampling * (high_ohm - low_ohm);
  b := low_ohm * high_ohm * Sqr(time_sampling);
  // Init the array
  for i := 0 to data_size - 1 do
  begin
    band_pass_result[i] := 0;
  end;

  // Initial entry to remove delay
  for i := 0 to 10 do
  begin
    band_pass_result[-i] := band_pass_result[0];
    data_input[-i] := data_input[0];
  end;

  // 2nd order butterworth bpf
  for n := 0 to data_size - 1 do
  begin
    band_pass_result[n] := (a * (data_input[n] - data_input[n-2]) - (2 * b - 8) * band_pass_result[n-1] - (4 + b - a) * band_pass_result[n-2]) / (4 + a + b);
    if (n / sampling_freq) < 0.02 then
    begin
      band_pass_result[n] := band_pass_result[n] * 0.5;
    end;

    Series2.AddXY(n/sampling_freq, band_pass_result[n]);
  end;
end;

procedure TForm1.btn4Click(Sender: TObject);
var
  i : Integer;
begin
  Series3.Clear;
  for i := 0 to data_size - 1 do
  begin
    abs_result[i] := Abs(band_pass_result[i]);
    Series3.AddXY(i/sampling_freq, abs_result[i]);
  end;
end;

procedure TForm1.btn5Click(Sender: TObject);
var
  i, j : Integer;
  sum : Double;
begin
  // do MAV here
  Series4.Clear;
  filter_order := StrToFloat(lbledt3.Text);
  for i := 0 to data_size - 1 do
  begin
    mav_result[i] := 0;
  end;

  // Forward MAV
  for i := 0 to data_size - 1 do
  begin
    sum := 0;
    for j := 0 to Round(filter_order) - 1 do
    begin
      if (i - j) >= 0 then
        sum := sum + abs_result[i - j];
    end;
    mav_result[i] := sum / filter_order;
    Series4.AddXY(i/sampling_freq, mav_result[i]);
  end;

  // Backward MAV
  Series9.Clear;
  Series8.Clear;
  for i := data_size downto 0 do
  begin
    sum := 0;
    for j := 0 to Round(filter_order) - 1 do
    begin
      sum := sum + mav_result[i + j];
    end;
    backward_mav_result[i] := sum / filter_order;
    Series9.AddXY(i/sampling_freq, backward_mav_result[i]);
    Series8.AddXY(i/sampling_freq, backward_mav_result[i]);
  end;
end;

procedure TForm1.btn6Click(Sender: TObject);
var
  i, j, k, count_s2, count2_s2 : Integer;
begin
  Series5.Clear;
  Series10.Clear;
  Series11.Clear;
  Series12.Clear;
  threshold_s1 := -999999;
  count_s2 := 0;
  count2_s2 := 0;
  SetLength(rising_edge_time_s2, 0);
  SetLength(falling_edge_time_s2, 0);

  lst3.Clear;

  for i := 0 to data_size - 1 do
  begin
    if backward_mav_result[i] > threshold_s1 then
      threshold_s1 := backward_mav_result[i];
  end;

  threshold_s1 := StrToFloat(lbledt4.Text) * threshold_s1;
  threshold_s2 := StrToFloat(lbledt5.Text);

  for i := 0 to data_size - 1 do
  begin
    if backward_mav_result[i] > threshold_s1 then
      threshold_result_s1[i] := 1
    else
      threshold_result_s1[i] := 0;

    if backward_mav_result[i] > threshold_s2 then
      threshold_result_s2[i] := 1
    else
      threshold_result_s2[i] := 0;

    for j := 0 to data_size - 1 do
    begin
      threshold_result_s2[j] := threshold_result_s2[j] - threshold_result_s1[j];
      if threshold_result_s2[j] < 0 then
        threshold_result_s2[j] := 0;
    end;

    if (i/sampling_freq) < 0.1 then
    begin
      threshold_result_s2[i] := 0;
      threshold_result_s1[i] := 0;
    end;
  end;

  for j := 0 to data_size - 1 do
  begin
    if (threshold_result_s2[j - 1] = 0) and (threshold_result_s2[j] > 0) then
    begin
      SetLength(rising_edge_time_s2, count_s2 + 1);
      rising_edge_time_s2[count_s2] := j/sampling_freq;
      count_s2 := count_s2 + 1;
    end
    else if (threshold_result_s2[j + 1] = 0) and (threshold_result_s2[j] > 0) then
    begin
      SetLength(falling_edge_time_s2, count2_s2 + 1);
      falling_edge_time_s2[count2_s2] := j/sampling_freq;
      count2_s2 := count2_s2 + 1;
    end;

    for i := 0 to High(falling_edge_time_s2) do
    begin
      if (falling_edge_time_s2[i] - rising_edge_time_s2[i] < 0.05) then
      begin
        for k := Round(rising_edge_time_s2[i] * sampling_freq) to Round(falling_edge_time_s2[i] * sampling_freq) do
        begin
          threshold_result_s2[k] := 0;
        end;
      end;
    end;
  end;


  SetLength(rising_edge_time_s2, 0);
  SetLength(falling_edge_time_s2, 0);
  count_s2 := 0;
  count2_s2 := 0;
  for j := 0 to data_size - 1 do
  begin
    if (threshold_result_s2[j - 1] = 0) and (threshold_result_s2[j] > 0) then
    begin
      SetLength(rising_edge_time_s2, count_s2 + 1);
      rising_edge_time_s2[count_s2] := j/sampling_freq;
      count_s2 := count_s2 + 1;
    end
    else if (threshold_result_s2[j + 1] = 0) and (threshold_result_s2[j] > 0) then
    begin
      SetLength(falling_edge_time_s2, count2_s2 + 1);
      falling_edge_time_s2[count2_s2] := j/sampling_freq;
      count2_s2 := count2_s2 + 1;
    end;
  end;

  for i := 1 to High(falling_edge_time_s2) do
  begin
    if Abs(falling_edge_time_s2[i] - falling_edge_time_s2[i - 1]) < 0.5 then
    begin
      for k := Round(rising_edge_time_s2[i] * sampling_freq) to Round(falling_edge_time_s2[i] * sampling_freq) do
      begin
        threshold_result_s2[k] := 0;
      end;

      for j := i to High(falling_edge_time_s2) do
      begin
        falling_edge_time_s2[j] := falling_edge_time_s2[j + 1];
        rising_edge_time_s2[j] := rising_edge_time_s2[j + 1];
      end;
      SetLength(falling_edge_time_s2, Length(falling_edge_time_s2) - 1);
      SetLength(rising_edge_time_s2, Length(rising_edge_time_s2) - 1);
    end;
  end;

  for i := 0 to High(rising_edge_time_s2) do
  begin
    lst3.Items.Add('sequence ' + IntToStr(i + 1) + ': ' + FloatToStr(rising_edge_time_s2[i] + (falling_edge_time_s2[i] - rising_edge_time_s2[i]) / 2));
  end;

  for i := 0 to data_size - 1 do
  begin
  Series10.AddXY(i/sampling_freq, threshold_s1);
  Series5.AddXY(i/sampling_freq, threshold_s1 * threshold_result_s1[i]);

  Series11.AddXY(i/sampling_freq, threshold_s2);
  Series12.AddXY(i/sampling_freq, threshold_s2 * threshold_result_s2[i]);
  end;
end;

procedure TForm1.btn7Click(Sender: TObject);
var
  i, count, count2 : Integer;
begin
  Series6.Clear;
  Series7.Clear;
  Series13.Clear;
  Series14.Clear;
  Series15.Clear;
  Series16.Clear;
  Series17.Clear;
  count := 0;
  count2 := 0;
  SetLength(rising_edge_time, 0);
  SetLength(falling_edge_time, 0);
  lst1.Clear;

  for i := 0 to data_size - 1 do
  begin
    if (threshold_result_s1[i - 1] = 0) and (threshold_result_s1[i] > 0) then
    begin
      SetLength(rising_edge_time, count + 1);
      rising_edge_time[count] := i/sampling_freq;
      count := count + 1;
    end
    else if (threshold_result_s1[i + 1] = 0) and (threshold_result_s1[i] > 0) then
    begin
      SetLength(falling_edge_time, count2 + 1);
      falling_edge_time[count2] := i/sampling_freq;
      count2 := count2 + 1;
    end;
  end;

  for i := 0 to High(rising_edge_time) do
  begin
    lst1.Items.Add('sequence ' + IntToStr(i + 1) + ': ' + FloatToStr(rising_edge_time[i] + (falling_edge_time[i] - rising_edge_time[i]) / 2));
  end;

  for i := 0 to data_size - 1 do
  begin
    Series6.AddXY(i/sampling_freq, threshold_result_s1[i] * 0.1);
    Series7.AddXY(i/sampling_freq, threshold_result_s2[i] * 0.1);
    Series13.AddXY(i/sampling_freq, threshold_result_s1[i] * band_pass_result[i]);
    Series14.AddXY(i/sampling_freq, threshold_result_s2[i] * band_pass_result[i]);
    Series15.AddXY(i/sampling_freq, band_pass_result[i]);
    Series16.AddXY(i/sampling_freq, 0.1 * threshold_result_s1[i]);
    Series17.AddXY(i/sampling_freq, 0.1 * threshold_result_s2[i]);
  end;
end;

procedure TForm1.btn8Click(Sender: TObject);
var
  i, count, count2 : Integer;
  s1_s2_interval, s2_s1_interval : array of Double;
  sum_1, sum_2, systole_avr, diastole_avr : Double;
begin
  // systole 0.3 - 0.5
  // dyastole 0.5 - 0.7
  lst5.Clear;
  lst6.Clear;
  SetLength(s1_s2_interval, 0);
  SetLength(s2_s1_interval, 0);
  count := 0;
  count2 := 0;
  sum_1 := 0;
  sum_2 := 0;
  systole_avr := 0;
  diastole_avr := 0;

  for i := 0 to High(rising_edge_time) do
  begin
    if (i + 1) <= High(rising_edge_time_s2) then
    begin
      SetLength(s1_s2_interval, count + 1);
      s1_s2_interval[count] := (rising_edge_time_s2[i + 1] + (falling_edge_time_s2[i + 1] - rising_edge_time_s2[i + 1]) / 2) - (rising_edge_time[i] + (falling_edge_time[i] - rising_edge_time[i]) / 2);
      lst6.Items.Add('s1_s2: ' + FloatToStr(s1_s2_interval[count]));
      count := count + 1;
    end;

    if (i + 1) <= High(rising_edge_time_s2) then
    begin
      SetLength(s2_s1_interval, count2 + 1);
      s2_s1_interval[count2] := (rising_edge_time[i] + (falling_edge_time[i] - rising_edge_time[i]) / 2) - (rising_edge_time_s2[i] + (falling_edge_time_s2[i] - rising_edge_time_s2[i]) / 2);
      lst6.Items.Add('s2_s1: ' + FloatToStr(s2_s1_interval[count2]));
      count2 := count2 + 1;
    end;
  end;

  for i := 0 to High(s1_s2_interval) do
  begin
    sum_1 := sum_1 + s1_s2_interval[i];
  end;

  for i := 0 to High(s2_s1_interval) do
  begin
    sum_2 := sum_2 + s2_s1_interval[i];
  end;

  systole_avr := sum_1 / count;
  diastole_avr := sum_2 / count2;

  lst5.Items.Add('Systole interval : ' + FloatToStr(systole_avr));
  lst5.Items.Add('Diastole interval : ' + FloatToStr(diastole_avr));
end;

end.

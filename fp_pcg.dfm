object Form1: TForm1
  Left = 126
  Top = 192
  Width = 1215
  Height = 596
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 185
    Height = 28
    Caption = 'PCG Signal Processing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Poppins'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grp1: TGroupBox
    Left = 8
    Top = 48
    Width = 129
    Height = 561
    Caption = 'Control Panel'
    TabOrder = 0
    object btn1: TBitBtn
      Left = 16
      Top = 24
      Width = 97
      Height = 33
      Caption = 'Input Data'
      TabOrder = 0
      OnClick = btn1Click
    end
    object btn2: TBitBtn
      Left = 16
      Top = 520
      Width = 97
      Height = 33
      TabOrder = 1
      Kind = bkClose
    end
    object btn5: TBitBtn
      Left = 16
      Top = 272
      Width = 97
      Height = 33
      Caption = 'MAV'
      TabOrder = 2
      OnClick = btn5Click
    end
    object btn4: TBitBtn
      Left = 16
      Top = 232
      Width = 97
      Height = 33
      Caption = 'Absolute'
      TabOrder = 3
      OnClick = btn4Click
    end
    object btn3: TBitBtn
      Left = 16
      Top = 192
      Width = 97
      Height = 33
      Caption = 'Band-pass Filter'
      TabOrder = 4
      OnClick = btn3Click
    end
    object btn6: TBitBtn
      Left = 16
      Top = 400
      Width = 97
      Height = 33
      Caption = 'Threshold'
      TabOrder = 5
      OnClick = btn6Click
    end
    object btn7: TBitBtn
      Left = 16
      Top = 440
      Width = 97
      Height = 33
      Caption = 'Segmentasi'
      TabOrder = 6
      OnClick = btn7Click
    end
    object lbledt1: TLabeledEdit
      Left = 16
      Top = 80
      Width = 97
      Height = 21
      EditLabel.Width = 107
      EditLabel.Height = 13
      EditLabel.Caption = 'Low Frequency Cutoff'
      TabOrder = 7
      Text = '20'
    end
    object lbledt2: TLabeledEdit
      Left = 16
      Top = 120
      Width = 97
      Height = 21
      EditLabel.Width = 109
      EditLabel.Height = 13
      EditLabel.Caption = 'High Frequency Cutoff'
      TabOrder = 8
      Text = '30'
    end
    object lbledt3: TLabeledEdit
      Left = 16
      Top = 160
      Width = 97
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Filter Order'
      TabOrder = 9
      Text = '50'
    end
    object lbledt4: TLabeledEdit
      Left = 16
      Top = 328
      Width = 97
      Height = 21
      EditLabel.Width = 107
      EditLabel.Height = 13
      EditLabel.Caption = 'S1 Threshold Multiplier'
      TabOrder = 10
      Text = '0.333'
    end
    object lbledt5: TLabeledEdit
      Left = 16
      Top = 368
      Width = 97
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'S2 Threshold'
      TabOrder = 11
      Text = '0.015'
    end
    object btn8: TBitBtn
      Left = 16
      Top = 480
      Width = 97
      Height = 33
      Caption = 'Calculate Interval'
      TabOrder = 12
      OnClick = btn8Click
    end
  end
  object cht1: TChart
    Left = 144
    Top = 48
    Width = 400
    Height = 225
    Legend.Visible = False
    Title.Text.Strings = (
      'Raw Signal')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 1
    PrintMargins = (
      15
      28
      15
      28)
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Raw Signal'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht2: TChart
    Left = 560
    Top = 48
    Width = 400
    Height = 225
    Legend.Visible = False
    Title.Text.Strings = (
      'Band-pass Filtered')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 2
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht3: TChart
    Left = 144
    Top = 288
    Width = 400
    Height = 225
    Legend.Visible = False
    Title.Text.Strings = (
      'Absolute')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 3
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht4: TChart
    Left = 560
    Top = 288
    Width = 400
    Height = 225
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'MAV')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 4
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Forward MAV'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series9: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Backward MAV'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht5: TChart
    Left = 968
    Top = 48
    Width = 401
    Height = 225
    Legend.Alignment = laTop
    Legend.CheckBoxes = True
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'Thresholding')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 5
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'S1 Segmentation'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series8: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'MAV'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series10: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = -1
      Title = 'Threshold S1'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series11: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = 16711808
      Title = 'Threshold S2'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series12: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'S2 Segmentation'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht6: TChart
    Left = 968
    Top = 288
    Width = 400
    Height = 225
    Legend.Alignment = laTop
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'Segmentasi S1')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 6
    object Series6: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'S1'
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series13: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'PCG Signal'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object cht7: TChart
    Left = 968
    Top = 528
    Width = 400
    Height = 225
    Legend.Alignment = laTop
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'Segmentasi S2')
    BottomAxis.Title.Caption = 'Time (s)'
    LeftAxis.Title.Caption = 'Amplitude'
    View3D = False
    TabOrder = 7
    object Series7: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'S2'
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series14: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'PCG Signal'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object lst1: TListBox
    Left = 1384
    Top = 288
    Width = 121
    Height = 225
    ItemHeight = 13
    TabOrder = 8
  end
  object lst3: TListBox
    Left = 1384
    Top = 528
    Width = 121
    Height = 225
    ItemHeight = 13
    TabOrder = 9
  end
  object cht8: TChart
    Left = 144
    Top = 528
    Width = 817
    Height = 225
    Legend.CheckBoxes = True
    Legend.TopPos = 11
    MarginTop = 5
    Title.Text.Strings = (
      'Final Result')
    View3D = False
    TabOrder = 10
    object Series15: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'PCG Signal'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series16: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'S1 Segment'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series17: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'S2 Segment'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object lst5: TListBox
    Left = 16
    Top = 616
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 11
  end
  object lst6: TListBox
    Left = 1384
    Top = 48
    Width = 121
    Height = 225
    ItemHeight = 13
    TabOrder = 12
  end
  object open_dialog: TOpenDialog
    Left = 24
    Top = 752
  end
end

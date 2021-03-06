{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }

{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }

{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/04/2013:  Daniel Sim�es de Almeida
|*   Inicio do desenvolvimento
******************************************************************************}

{$I ACBr.inc}

unit ACBrPosPrinter;

interface

uses
  Classes, SysUtils,
  ACBrDevice, ACBrBase;

type

  EPosPrinterException = class(Exception);

  { TACBrPosComandos }

  TACBrPosComandos = class
  private
    FBeep: AnsiString;
    FAlinhadoCentro: AnsiString;
    FAlinhadoDireita: AnsiString;
    FAlinhadoEsquerda: AnsiString;
    FCorteParcial: AnsiString;
    FDesligaInvertido: AnsiString;
    FEspacoEntreLinhasPadrao: AnsiString;
    FLigaInvertido: AnsiString;
    FFonteNormal: AnsiString;
    FLigaCondensado: AnsiString;
    FCorteTotal: AnsiString;
    FEspacoEntreLinhas: AnsiString;
    FLigaExpandido: AnsiString;
    FDesligaCondensado: AnsiString;
    FDesligaExpandido: AnsiString;
    FDesligaItalico: AnsiString;
    FDesligaNegrito: AnsiString;
    FDesligaSublinhado: AnsiString;
    FFonteA: AnsiString;
    FFonteB: AnsiString;
    FLigaItalico: AnsiString;
    FLigaNegrito: AnsiString;
    FLigaSublinhado: AnsiString;
    FPuloDeLinha: AnsiString;
    FZera: AnsiString;
  public
    property Zera: AnsiString read FZera write FZera;
    property EspacoEntreLinhas: AnsiString read FEspacoEntreLinhas
      write FEspacoEntreLinhas;
    property EspacoEntreLinhasPadrao: AnsiString
      read FEspacoEntreLinhasPadrao write FEspacoEntreLinhasPadrao;

    property LigaNegrito: AnsiString read FLigaNegrito write FLigaNegrito;
    property DesligaNegrito: AnsiString read FDesligaNegrito write FDesligaNegrito;
    property LigaExpandido: AnsiString read FLigaExpandido write FLigaExpandido;
    property DesligaExpandido: AnsiString read FDesligaExpandido write FDesligaExpandido;
    property LigaSublinhado: AnsiString read FLigaSublinhado write FLigaSublinhado;
    property DesligaSublinhado: AnsiString read FDesligaSublinhado
      write FDesligaSublinhado;
    property LigaItalico: AnsiString read FLigaItalico write FLigaItalico;
    property DesligaItalico: AnsiString read FDesligaItalico write FDesligaItalico;
    property LigaCondensado: AnsiString read FLigaCondensado write FLigaCondensado;
    property DesligaCondensado: AnsiString read FDesligaCondensado
      write FDesligaCondensado;
    property LigaInvertido: AnsiString read FLigaInvertido write FLigaInvertido;
    property DesligaInvertido: AnsiString read FDesligaInvertido write FDesligaInvertido;

    property FonteNormal: AnsiString read FFonteNormal write FFonteNormal;
    property FonteA: AnsiString read FFonteA write FFonteA;
    property FonteB: AnsiString read FFonteB write FFonteB;

    property AlinhadoEsquerda: AnsiString read FAlinhadoEsquerda write FAlinhadoEsquerda;
    property AlinhadoDireita: AnsiString read FAlinhadoDireita write FAlinhadoDireita;
    property AlinhadoCentro: AnsiString read FAlinhadoCentro write FAlinhadoCentro;

    property Beep: AnsiString read FBeep write FBeep;
    property CorteTotal: AnsiString read FCorteTotal write FCorteTotal;
    property CorteParcial: AnsiString read FCorteParcial write FCorteParcial;
    property PuloDeLinha: AnsiString read FPuloDeLinha write FPuloDeLinha;
  end;

  TACBrPosTipoFonte = (ftNormal, ftCondensado, ftExpandido, ftNegrito,
    ftSublinhado, ftInvertido, ftItalico, ftFonteB);
  TACBrPosFonte = set of TACBrPosTipoFonte;

  TACBrPosTipoAlinhamento = (alEsquerda, alCentro, alDireita);
  TACBrPosPaginaCodigo = (pcNone, pc437, pc850, pc852, pc860, pcUTF8, pc1252);

  TACBrPosTipoStatus = (stErro, stNaoSerial, stPoucoPapel, stSemPapel,
                        stGavetaAberta, stImprimindo, stOffLine, stTampaAberta);
  TACBrPosPrinterStatus = set of TACBrPosTipoStatus;

  { TACBrPosRazaoColunaFonte }
  {$M+}
  TACBrPosRazaoColunaFonte = class
  private
    FCondensada: Double;
    FExpandida: Double;
  public
    constructor Create;
  published
    property Condensada: Double read FCondensada write FCondensada;
    property Expandida: Double read FExpandida write FExpandida;
  end;
  {$M-}

  TACBrPosPrinter = class;

  TACBrPosPrinterModelo = (ppTexto, ppEscPosEpson, ppEscBematech, ppEscDaruma,
                           ppEscElgin, ppEscDiebold);

  { TACBrPosPrinterClass }

  TACBrPosPrinterClass = class
  private
    FCmd: TACBrPosComandos;
    FRazaoColunaFonte: TACBrPosRazaoColunaFonte;
    FTagsNaoSuportadas: TStringList;

  protected
    fpModeloStr: String;
    fpPosPrinter: TACBrPosPrinter;

  public
    function TraduzirTagBloco(const ATag, ConteudoBloco: AnsiString): AnsiString;
      virtual;
    function ComandoCodBarras(const ATag: String; ACodigo: AnsiString): AnsiString;
      virtual;
    function ComandoQrCode(ACodigo: AnsiString): AnsiString; virtual;
    function ComandoEspacoEntreLinhas(Espacos: byte): AnsiString; virtual;
    function ComandoPaginaCodigo(APagCodigo: TACBrPosPaginaCodigo): AnsiString; virtual;
    function ComandoLogo: AnsiString; virtual;
    function ComandoGaveta(NumGaveta: Integer = 1): AnsiString; virtual;
    function ComandoInicializa: AnsiString; virtual;
    function ComandoPuloLinhas(NLinhas: Integer): AnsiString; virtual;
    function ComandoFonte(TipoFonte: TACBrPosTipoFonte; Ligar: Boolean): AnsiString; virtual;

    procedure Configurar; virtual;
    procedure LerStatus(var AStatus: TACBrPosPrinterStatus); virtual;
    function LerInfo: String; virtual;

    constructor Create(AOwner: TACBrPosPrinter);
    destructor Destroy; override;

    property RazaoColunaFonte: TACBrPosRazaoColunaFonte read FRazaoColunaFonte;
    property Cmd: TACBrPosComandos read FCmd;
    property ModeloStr: String read fpModeloStr;

    property TagsNaoSuportadas: TStringList read FTagsNaoSuportadas;
  end;

  { TACBrConfigQRCode }

  TACBrConfigQRCode = class(TPersistent)
    private
      FErrorLevel: Integer;
      FLarguraModulo: Integer;
      FTipo: Integer;
      procedure SetErrorLevel(AValue: Integer);
      procedure SetLarguraModulo(AValue: Integer);
      procedure SetTipo(AValue: Integer);
    public
      constructor Create;

    published
      property Tipo: Integer read FTipo write SetTipo;
      property LarguraModulo: Integer read FLarguraModulo write SetLarguraModulo;
      property ErrorLevel: Integer read FErrorLevel write SetErrorLevel;
  end;

  { TACBrConfigLogo }

  TACBrConfigLogo = class(TPersistent)
    private
      FFatorX: Byte;
      FFatorY: Byte;
      FIgnorarLogo: Boolean;
      FKeyCode1: Byte;
      FKeyCode2: Byte;
    public
      constructor Create;

    published
      property IgnorarLogo: Boolean read FIgnorarLogo write FIgnorarLogo default False;
      property KeyCode1: Byte read FKeyCode1 write FKeyCode1 default 32;
      property KeyCode2: Byte read FKeyCode2 write FKeyCode2 default 32;
      property FatorX: Byte read FFatorX write FFatorX default 1;
      property FatorY: Byte read FFatorY write FFatorY default 1;
  end;

  { TACBrConfigGaveta }

  TACBrConfigGaveta = class(TPersistent)
    private
      FSinalInvertido: Boolean;
      FTempoOFF: Byte;
      FTempoON: Byte;

    public
      constructor Create;

    published
      property SinalInvertido: Boolean read FSinalInvertido
        write FSinalInvertido default False;
      property TempoON: Byte read FTempoON write FTempoON default 50;
      property TempoOFF: Byte read FTempoOFF write FTempoOFF default 200;
  end;

  { TACBrPosPrinter }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TACBrPosPrinter = class(TACBrComponent)
  private
    FColunasFonteNormal: Integer;
    FConfigBarras: TACBrECFConfigBarras;
    FConfigLogo: TACBrConfigLogo;
    FConfigQRCode: TACBrConfigQRCode;
    FControlePorta: Boolean;
    FDevice: TACBrDevice;
    FEspacoEntreLinhas: byte;
    FConfigGaveta: TACBrConfigGaveta;
    FModelo: TACBrPosPrinterModelo;
    FOnGravarLog: TACBrGravarLog;
    FOnEnviarStringDevice: TACBrGravarLog;
    FTagProcessor: TACBrTagProcessor;

    FCortaPapel: Boolean;
    FLinhasBuffer: Integer;
    FLinhasEntreCupons: Integer;
    FPaginaDeCodigo: TACBrPosPaginaCodigo;
    FArqLog: String;

    FBuffer: TStringList;
    FTipoAlinhamento: TACBrPosTipoAlinhamento;
    FFonteStatus: TACBrPosFonte;
    FInicializada: Boolean;
    FVerificarImpressora: Boolean;

    function GetAtivo: Boolean;
    function GetColunasFonteCondensada: Integer;
    function GetColunasFonteExpandida: Integer;
    function GetNumeroPaginaDeCodigo(APagCod: TACBrPosPaginaCodigo): word;
    function CodificarPaginaDeCodigo(ATexto: AnsiString): AnsiString;

    procedure DoLinesChange(Sender: TObject);
    function GetColunas: Integer;
    function GetIgnorarTags: Boolean;
    function GetPorta: String;
    function GetTagsNaoSuportadas: TStringList;
    function GetTraduzirTags: Boolean;
    procedure SetAtivo(AValue: Boolean);
    procedure SetIgnorarTags(AValue: Boolean);
    procedure SetPorta(AValue: String);
    procedure SetTraduzirTags(AValue: Boolean);
    procedure SetModelo(AValue: TACBrPosPrinterModelo);

  protected
    FPosPrinterClass: TACBrPosPrinterClass;
    procedure EnviarStringDevice(AString: AnsiString);
    procedure TraduzirTag(const ATag: AnsiString; var TagTraduzida: AnsiString);
    procedure TraduzirTagBloco(const ATag, ConteudoBloco: AnsiString;
      var BlocoTraduzido: AnsiString);

    procedure AtivarPorta;
    procedure DesativarPorta;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Ativar;
    procedure Desativar;
    property Ativo: Boolean read GetAtivo write SetAtivo;

    procedure Imprimir(AString: AnsiString = ''; PulaLinha: Boolean = False;
      DecodificarTags: Boolean = True; CodificarPagina: Boolean = True;
      Copias: Integer = 1);
    procedure ImprimirLinha(AString: AnsiString);
    procedure ImprimirCmd(AString: AnsiString);
    procedure GravarLog(AString: AnsiString; Traduz: Boolean = False;
      AdicionaTempo: Boolean = True);

    function TxRx(ACmd: AnsiString; BytesToRead: Byte = 1;
      ATimeOut: Integer = 500; WaitForTerminator: Boolean = False): AnsiString;

    procedure RetornarTags(AStringList: TStrings; IncluiAjuda: Boolean = True);
    procedure ImprimirTags;

    procedure Zerar;
    procedure Inicializar;

    procedure PularLinhas(NumLinhas: Integer = 0);
    procedure CortarPapel(Parcial: Boolean = False);
    procedure AbrirGaveta;

    function LerStatusImpressora: TACBrPosPrinterStatus;
    function LerInfoImpressora: String;

    property Buffer: TStringList read FBuffer;

    property Colunas: Integer read GetColunas;
    property ColunasFonteExpandida: Integer read GetColunasFonteExpandida;
    property ColunasFonteCondensada: Integer read GetColunasFonteCondensada;

    property FonteStatus: TACBrPosFonte read FFonteStatus;
    property Alinhamento: TACBrPosTipoAlinhamento read FTipoAlinhamento;
    property Inicializada: Boolean read FInicializada;

    property TagsNaoSuportadas: TStringList read GetTagsNaoSuportadas;

  published
    property Modelo: TACBrPosPrinterModelo read FModelo write SetModelo default ppTexto;
    property Porta: String read GetPorta write SetPorta;
    property Device: TACBrDevice read FDevice;

    property PaginaDeCodigo: TACBrPosPaginaCodigo
      read FPaginaDeCodigo write FPaginaDeCodigo default pc850;
    property ColunasFonteNormal: Integer read FColunasFonteNormal
      write FColunasFonteNormal default 48;
    property EspacoEntreLinhas: byte read FEspacoEntreLinhas
      write FEspacoEntreLinhas default 0;

    property ConfigBarras: TACBrECFConfigBarras read FConfigBarras write FConfigBarras;
    property ConfigQRCode: TACBrConfigQRCode read FConfigQRCode write FConfigQRCode;
    property ConfigLogo: TACBrConfigLogo read FConfigLogo write FConfigLogo;
    property ConfigGaveta: TACBrConfigGaveta read FConfigGaveta write FConfigGaveta;

    property LinhasEntreCupons: Integer read FLinhasEntreCupons
      write FLinhasEntreCupons default 21;
    property CortaPapel: Boolean read FCortaPapel write FCortaPapel default True;

    property TraduzirTags: Boolean read GetTraduzirTags
      write SetTraduzirTags default True;
    property IgnorarTags: Boolean read GetIgnorarTags write SetIgnorarTags default False;
    property LinhasBuffer: Integer read FLinhasBuffer write FLinhasBuffer default 0;
    property ControlePorta: Boolean read FControlePorta write FControlePorta default False;
    property VerificarImpressora: Boolean read FVerificarImpressora write FVerificarImpressora default False;

    property OnGravarLog: TACBrGravarLog read FOnGravarLog write FOnGravarLog;
    property ArqLOG: String read FArqLog write FArqLog;
    property OnEnviarStringDevice: TACBrGravarLog read FOnEnviarStringDevice write FOnEnviarStringDevice;
  end;

implementation

uses
  strutils, Math, typinfo,
  ACBrUtil, ACBrConsts,
  ACBrEscPosEpson, ACBrEscBematech, ACBrEscDaruma, ACBrEscElgin, ACBrEscDiebold;

{ TACBrConfigGaveta }

constructor TACBrConfigGaveta.Create;
begin
  FTempoON := 50;
  FTempoOFF := 200;
  FSinalInvertido := False;
end;

{ TACBrConfigLogo }

constructor TACBrConfigLogo.Create;
begin
  FKeyCode1 := 32;
  FKeyCode2 := 32;
  FFatorX := 1;
  FFatorY := 1;
  FIgnorarLogo := False;
end;

{ TACBrConfigQRCode }

constructor TACBrConfigQRCode.Create;
begin
  inherited;

  FTipo := 2;
  FLarguraModulo := 4;
  FErrorLevel := 0;
end;

procedure TACBrConfigQRCode.SetLarguraModulo(AValue: Integer);
begin
  FLarguraModulo := max(min(AValue,16),1);
end;

procedure TACBrConfigQRCode.SetErrorLevel(AValue: Integer);
begin
  FErrorLevel := max(min(AValue,3),0);
end;

procedure TACBrConfigQRCode.SetTipo(AValue: Integer);
begin
  FTipo := max(min(AValue,2),1);
end;

{ TACBrPosRazaoColunaFonte }

constructor TACBrPosRazaoColunaFonte.Create;
begin
  FCondensada := 0.75;
  FExpandida := 2;
end;

{ TACBrPosPrinterClass }

constructor TACBrPosPrinterClass.Create(AOwner: TACBrPosPrinter);
begin
  inherited Create;

  fpModeloStr := 'Texto';
  fpPosPrinter := AOwner;

  FCmd := TACBrPosComandos.Create;
  FRazaoColunaFonte := TACBrPosRazaoColunaFonte.Create;
  FTagsNaoSuportadas := TStringList.Create;
end;

destructor TACBrPosPrinterClass.Destroy;
begin
  FCmd.Free;
  FRazaoColunaFonte.Free;
  FTagsNaoSuportadas.Free;

  inherited;
end;

function TACBrPosPrinterClass.TraduzirTagBloco(
  const ATag, ConteudoBloco: AnsiString): AnsiString;
begin
  Result := ConteudoBloco;
end;

function TACBrPosPrinterClass.ComandoCodBarras(const ATag: String;
  ACodigo: AnsiString): AnsiString;
begin
  Result := ACodigo;
end;

function TACBrPosPrinterClass.ComandoQrCode(ACodigo: AnsiString): AnsiString;
begin
  Result := '';
end;

function TACBrPosPrinterClass.ComandoEspacoEntreLinhas(Espacos: byte): AnsiString;
begin
  if Espacos = 0 then
    Result := Cmd.EspacoEntreLinhasPadrao
  else
  begin
    if Length(Cmd.EspacoEntreLinhas) > 0 then
      Result := Cmd.EspacoEntreLinhas + AnsiChr(Espacos)
    else
      Result := '';
  end;
end;

function TACBrPosPrinterClass.ComandoPaginaCodigo(
  APagCodigo: TACBrPosPaginaCodigo): AnsiString;
begin
  Result := '';
end;

function TACBrPosPrinterClass.ComandoLogo: AnsiString;
begin
  Result := '';
end;

function TACBrPosPrinterClass.ComandoGaveta(NumGaveta: Integer): AnsiString;
begin
  Result := '';
end;

function TACBrPosPrinterClass.ComandoInicializa: AnsiString;
begin
  Result := ComandoEspacoEntreLinhas(fpPosPrinter.EspacoEntreLinhas) +
            ComandoPaginaCodigo(fpPosPrinter.PaginaDeCodigo);
end;

function TACBrPosPrinterClass.ComandoPuloLinhas(NLinhas: Integer): AnsiString;
begin
  Result := AnsiString( DupeString(' '+Cmd.PuloDeLinha,NLinhas) );
end;

function TACBrPosPrinterClass.ComandoFonte(TipoFonte: TACBrPosTipoFonte;
  Ligar: Boolean): AnsiString;
begin
  Result := '';

  case TipoFonte of
    ftExpandido:
      if Ligar then
        Result := Cmd.LigaExpandido
      else
        Result := Cmd.DesligaExpandido;

    ftCondensado:
      if Ligar then
        Result := Cmd.LigaCondensado
      else
        Result :=  Cmd.DesligaCondensado;

    ftNegrito:
      if Ligar then
        Result := Cmd.LigaNegrito
      else
        Result := Cmd.DesligaNegrito;

    ftItalico:
      if Ligar then
        Result := Cmd.LigaItalico
      else
         Result := Cmd.DesligaItalico;

    ftInvertido:
       if Ligar then
         Result := Cmd.LigaInvertido
       else
         Result := Cmd.DesligaInvertido;

    ftSublinhado:
       if Ligar then
         Result := Cmd.LigaSublinhado
       else
         Result := Cmd.DesligaSublinhado;

    ftFonteB:
      if Ligar then
        Result := Cmd.FonteB
      else
        Result := Cmd.FonteA;
  end;
end;

procedure TACBrPosPrinterClass.Configurar;
begin
  {nada aqui, m�todo virtual}
end;

procedure TACBrPosPrinterClass.LerStatus(var AStatus: TACBrPosPrinterStatus);
begin
  {nada aqui, m�todo virtual}
end;

function TACBrPosPrinterClass.LerInfo: String;
begin
  Result := '';
end;

{ TACBrPosPrinter }

constructor TACBrPosPrinter.Create(AOwner: TComponent);
const
  CTAGS_TIPOFONTE: array[0..6] of String =
    (cTagFonteA, cTagFonteB, cTagLigaInvertido, cTagDesligaInvertido,
     cTagFonteAlinhadaEsquerda, cTagfonteAlinhadaCentro, cTagFonteAlinhadaDireita);
  CTAGS_TIPOFONTE_HELP: array[0..6] of String =
    ('Liga Fonte Tipo A (normal)',
     'Liga Fonte Tipo B (condensada)',
     'Liga Fonte Invertida (Fundo Preto)', 'Desliga Fonte Invertida',
     'Liga Alinhamento a Esquerda',
     'Liga Alinhamento ao Centro',
     'Liga Alinhamento a Direita');
begin
  inherited Create(AOwner);

  FDevice := TACBrDevice.Create(Self);
  FDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  {$IFDEF COMPILER6_UP}
  FDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}
  FPosPrinterClass := TACBrPosPrinterClass.Create(Self);
  FModelo := ppTexto;
  FTipoAlinhamento := alEsquerda;
  FFonteStatus := [ftNormal];
  FInicializada := False;

  FConfigBarras := TACBrECFConfigBarras.Create;
  FConfigQRCode := TACBrConfigQRCode.Create;
  FConfigLogo   := TACBrConfigLogo.Create;
  FConfigGaveta := TACBrConfigGaveta.Create;

  FTagProcessor := TACBrTagProcessor.Create;
  FTagProcessor.AddTags(cTAGS_CARACTER, cTAGS_CARACTER_HELP, False);
  FTagProcessor.AddTags(CTAGS_TIPOFONTE, CTAGS_TIPOFONTE_HELP, False);
  FTagProcessor.AddTags(cTAGS_LINHAS, cTAGS_LINHAS_HELP, False);
  FTagProcessor.AddTags(cTAGS_FUNCOES, cTAGS_FUNCOES_HELP, False);
  FTagProcessor.AddTags(cTAGS_ALINHAMENTO, cTAGS_ALINHAMENTO_HELP, True);
  FTagProcessor.AddTags(cTAGS_BARRAS, cTAGS_BARRAS_HELP, True);

  // Abertura de Gaveta espec�fica //
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagAbreGavetaEsp;
    Ajuda := 'Abertura de Gaveta Espec�fica (1 ou 2)';
    EhBloco := True;
  end;

  // Tags de Configura��es do Cod.Barras //
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagBarraMostrar;
    Ajuda := 'Configura se deve exibir conteudo abaixo do Cod.Barras: 0-NAO; 1-SIM';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagBarraLargura;
    Ajuda := 'Configura a Largura das Barras do Cod.Barras: 0 a 5. (0=default)';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagBarraAltura;
    Ajuda := 'Configura a Altura do Cod.Barras: 0 a 255. (0=default)';
    EhBloco := True;
  end;

  // Tags de QRCode e configura��o do QRCode //
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagQRCode;
    Ajuda := 'Imprime QRCode de acordo com "ConfigQRCode"';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagQRCodeTipo;
    Ajuda := 'Configura o Tipo de QRCode: 1,2';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagQRCodeLargura;
    Ajuda := 'Configura a Largura do QRCode: 1 a 16';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagQRCodeError;
    Ajuda := 'Configura o Error Level do QRCode: 0 a 3';
    EhBloco := True;
  end;

  // Tags de configura��o do LogoTipo //
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagLogoImprimir;
    Ajuda := 'Configura a Impress�o ou n�o do Logo Tipo: 0-N�O, 1-SIM (default = 1)';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagLogoKC1;
    Ajuda := 'Configura a posi��o KC1 do Logo a ser impresso. Ex: 0=48';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagLogoKC2;
    Ajuda := 'Configura a posi��o KC2 do Logo a ser impresso. Ex: 1=49';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagLogoFatorX;
    Ajuda := 'Configura o aumento Horizonal do Logo, de 1 a 4';
    EhBloco := True;
  end;
  with FTagProcessor.Tags.New do
  begin
    Nome := cTagLogoFatorY;
    Ajuda := 'Configura o aumento Vertical do Logo, de 1 a 4';
    EhBloco := True;
  end;

  with FTagProcessor.Tags.New do
  begin
    Nome := cTagIgnorarTags;
    Ajuda := 'Ignora todas as Tags contidas no Bloco';
    EhBloco := True;
  end;

  FTagProcessor.OnTraduzirTag := TraduzirTag;
  FTagProcessor.OnTraduzirTagBloco := TraduzirTagBloco;

  FBuffer := TStringList.Create;
  FBuffer.OnChange := DoLinesChange;

  FColunasFonteNormal := 48;
  FPaginaDeCodigo := pc850;
  FEspacoEntreLinhas := 0;
  FControlePorta := False;
  FCortaPapel := True;
  FVerificarImpressora := False;

  FArqLog := '';
  FOnGravarLog := nil;
  FOnEnviarStringDevice := nil;
end;

destructor TACBrPosPrinter.Destroy;
begin
  FPosPrinterClass.Free;
  FBuffer.Free;
  FTagProcessor.Free;
  FConfigBarras.Free;
  FConfigQRCode.Free;
  FConfigLogo.Free;
  FConfigGaveta.Free;
  FDevice.Free;

  inherited Destroy;
end;

procedure TACBrPosPrinter.AbrirGaveta;
begin
  GravarLog('AbrirGaveta');
  ImprimirCmd(FPosPrinterClass.ComandoGaveta());
  Sleep(500);
end;

procedure TACBrPosPrinter.Ativar;
var
  DadosDevice: String;
begin
  if FDevice.Ativo then
    exit;

{(*}
  if FDevice.IsTXTFilePort then
    DadosDevice := '  - Arquivo: '+FDevice.Porta
  else if FDevice.IsDLLPort then
    DadosDevice := '  - DLL....: '+FDevice.Porta
  else if FDevice.IsSerialPort then
    DadosDevice := '  - Serial.: '+FDevice.Porta+' - '+FDevice.DeviceToString(False)
  else
    DadosDevice := '  - Porta..: '+FDevice.Porta;

  GravarLog(AnsiString(sLineBreak + StringOfChar('-', 80) + sLineBreak +
            'ATIVAR - ' + FormatDateTime('dd/mm/yy hh:nn:ss:zzz', now) + sLineBreak +
            '  - Modelo.: ' + FPosPrinterClass.ModeloStr + sLineBreak +
            '  - TimeOut: ' + IntToStr(FDevice.TimeOut) + sLineBreak +
            DadosDevice + sLineBreak +
            StringOfChar('-', 80) + sLineBreak),
            False, False);
  {*)}

  FDevice.Ativar;
  FPosPrinterClass.Configurar;
  FInicializada := False;
end;

procedure TACBrPosPrinter.Desativar;
begin
  GravarLog(AnsiString(sLineBreak + StringOfChar('-', 80) + sLineBreak +
    'DESATIVAR - ' + FormatDateTime('dd/mm/yy hh:nn:ss:zzz', now) +
    sLineBreak + StringOfChar('-', 80) + sLineBreak),
    False, False);

  FDevice.Desativar;
  FInicializada := False;
end;

procedure TACBrPosPrinter.SetModelo(AValue: TACBrPosPrinterModelo);
begin
  if FModelo = AValue then
    Exit;

  if Ativo then
    Desativar;

  GravarLog('SetModelo(' + AnsiString(GetEnumName(TypeInfo(TACBrPosPrinterModelo),
    integer(AValue))) + ')');

  FPosPrinterClass.Free;

  case AValue of
    ppEscPosEpson: FPosPrinterClass := TACBrEscPosEpson.Create(Self);
    ppEscBematech: FPosPrinterClass := TACBrEscBematech.Create(Self);
    ppEscDaruma : FPosPrinterClass := TACBrEscDaruma.Create(Self);
    ppEscElgin : FPosPrinterClass := TACBrEscElgin.Create(Self);
    ppEscDiebold : FPosPrinterClass := TACBrEscDiebold.Create(Self);
  else
    FPosPrinterClass := TACBrPosPrinterClass.Create(Self);
  end;

  FModelo := AValue;
end;

procedure TACBrPosPrinter.DoLinesChange(Sender: TObject);
begin
  if (FLinhasBuffer > 0) and (FBuffer.Count > FLinhasBuffer) then
  begin
    GravarLog(AnsiString('Esvaziando Buffer: ' + IntToStr(FBuffer.Count) + ' linhas'));
    Imprimir;
  end;
end;

function TACBrPosPrinter.GetColunas: Integer;
begin
  if (ftCondensado in FFonteStatus) then
    Result := ColunasFonteCondensada
  else if (ftExpandido in FFonteStatus) then
    Result := ColunasFonteExpandida
  else
    Result := ColunasFonteNormal;
end;

function TACBrPosPrinter.GetColunasFonteCondensada: Integer;
begin
  Result := trunc(ColunasFonteNormal / FPosPrinterClass.RazaoColunaFonte.Condensada)
end;

function TACBrPosPrinter.GetColunasFonteExpandida: Integer;
begin
  Result := trunc(ColunasFonteNormal / FPosPrinterClass.RazaoColunaFonte.Expandida)
end;


procedure TACBrPosPrinter.TraduzirTag(const ATag: AnsiString;
  var TagTraduzida: AnsiString);
begin
  TagTraduzida := '';

  if ATag = cTagLigaExpandido then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftExpandido, True);
    FFonteStatus := FFonteStatus + [ftExpandido];
  end

  else if ATag = cTagDesligaExpandido then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftExpandido, False);
    FFonteStatus := FFonteStatus - [ftExpandido];
  end

  else if ATag = cTagLigaNegrito then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftNegrito, True);
    FFonteStatus := FFonteStatus + [ftNegrito];
  end

  else if ATag = cTagDesligaNegrito then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftNegrito, False);
    FFonteStatus := FFonteStatus - [ftNegrito];
  end

  else if ATag = cTagLigaSublinhado then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftSublinhado, True);
    FFonteStatus := FFonteStatus + [ftSublinhado];
  end

  else if ATag = cTagDesligaSublinhado then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftSublinhado, False);
    FFonteStatus := FFonteStatus - [ftSublinhado];
  end

  else if ATag = cTagLigaCondensado then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftCondensado, True);
    FFonteStatus := FFonteStatus + [ftCondensado];
  end

  else if ATag = cTagDesligaCondensado then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftCondensado, False);
    FFonteStatus := FFonteStatus - [ftCondensado];
  end

  else if ATag = cTagLigaItalico then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftItalico, True);
    FFonteStatus := FFonteStatus + [ftItalico];
  end

  else if ATag = cTagDesligaItalico then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftItalico, False);
    FFonteStatus := FFonteStatus - [ftItalico];
  end

  else if ATag = cTagFonteNormal then
  begin
    TagTraduzida := FPosPrinterClass.Cmd.FonteNormal;
    FFonteStatus := FFonteStatus - [ftCondensado, ftExpandido, ftNegrito,
      ftSublinhado, ftItalico, ftInvertido];
  end

  else if ATag = cTagZera then
  begin
    TagTraduzida := FPosPrinterClass.Cmd.Zera + FPosPrinterClass.ComandoInicializa;

    FInicializada := True;
    FFonteStatus := FFonteStatus - [ftCondensado, ftExpandido, ftNegrito,
                                    ftSublinhado, ftItalico, ftInvertido];
  end

  else if ATag = cTagLigaInvertido then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftInvertido, True);
    FFonteStatus := FFonteStatus + [ftInvertido];
  end

  else if ATag = cTagDesligaInvertido then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftInvertido, False);
    FFonteStatus := FFonteStatus - [ftInvertido];
  end

  else if ATag = cTagFonteA then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftFonteB, False);
    FFonteStatus := FFonteStatus - [ftFonteB];
  end

  else if ATag = cTagFonteB then
  begin
    TagTraduzida := FPosPrinterClass.ComandoFonte(ftFonteB, True);
    FFonteStatus := FFonteStatus + [ftFonteB];
  end

  else if ATag = cTagLinhaSimples then
    TagTraduzida := AnsiString(StringOfChar('-', Colunas))

  else if ATag = cTagLinhaDupla then
    TagTraduzida := AnsiString(StringOfChar('=', Colunas))

  else if ATag = cTagPuloDeLinhas then
    TagTraduzida := FPosPrinterClass.ComandoPuloLinhas(LinhasEntreCupons)

  else if ATag = cTagCorteParcial then
  begin
    TagTraduzida := FPosPrinterClass.ComandoPuloLinhas(LinhasEntreCupons);
    if CortaPapel then
      TagTraduzida := TagTraduzida + FPosPrinterClass.Cmd.CorteParcial;
  end

  else if ATag = cTagCorteTotal then
  begin
    TagTraduzida := FPosPrinterClass.ComandoPuloLinhas(LinhasEntreCupons);
    if CortaPapel then
      TagTraduzida := TagTraduzida + FPosPrinterClass.Cmd.CorteTotal;
  end

  else if ATag = cTagAbreGaveta then
    TagTraduzida := FPosPrinterClass.ComandoGaveta()

  else if ATag = cTagBeep then
    TagTraduzida := FPosPrinterClass.Cmd.Beep

  else if ATag = cTagLogotipo then
    if FConfigLogo.IgnorarLogo then
      TagTraduzida := ''
    else
      TagTraduzida := FPosPrinterClass.ComandoLogo

  else if ATag = cTagPulodeLinha then
    TagTraduzida := FPosPrinterClass.ComandoPuloLinhas(1)

  else if ATag = cTagRetornoDeCarro then
    TagTraduzida := CR

  else if ATag = cTagFonteAlinhadaEsquerda then
  begin
    TagTraduzida := FPosPrinterClass.Cmd.AlinhadoEsquerda;
    FTipoAlinhamento := alEsquerda;
  end

  else if ATag = cTagFonteAlinhadaDireita then
  begin
    TagTraduzida := FPosPrinterClass.Cmd.AlinhadoDireita;
    FTipoAlinhamento := alDireita;
  end

  else if ATag = cTagfonteAlinhadaCentro then
  begin
    TagTraduzida := FPosPrinterClass.Cmd.AlinhadoCentro;
    FTipoAlinhamento := alCentro;
  end;

  GravarLog(AnsiString('TraduzirTag(' + ATag + ') -> ') + TagTraduzida, True);
end;

procedure TACBrPosPrinter.TraduzirTagBloco(const ATag, ConteudoBloco: AnsiString;
  var BlocoTraduzido: AnsiString);
var
  ACodBar: String;
begin
  BlocoTraduzido := FPosPrinterClass.TraduzirTagBloco(ATag, ConteudoBloco);

  if ConteudoBloco = BlocoTraduzido then  // N�o traduziu...
  begin
    if ATag = cTagAlinhadoEsquerda then
      BlocoTraduzido := PadRight(ConteudoBloco,Colunas)

    else if ATag = cTagAlinhadoDireita then
      BlocoTraduzido := PadLeft(ConteudoBloco,Colunas)

    else if ATag = cTagAlinhadoCentro then
      BlocoTraduzido := PadCenter(ConteudoBloco,Colunas)

    else if ATag = cTagAbreGavetaEsp then
      BlocoTraduzido := FPosPrinterClass.ComandoGaveta( StrToIntDef( ConteudoBloco, 1) )

    else if ATag = cTagQRCodeTipo then
    begin
      BlocoTraduzido := '';
      ConfigQRCode.Tipo := StrToIntDef( ConteudoBloco, ConfigQRCode.Tipo);
    end

    else if ATag = cTagQRCodeLargura then
    begin
      BlocoTraduzido := '';
      ConfigQRCode.LarguraModulo := StrToIntDef( ConteudoBloco, ConfigQRCode.LarguraModulo);
    end

    else if ATag = cTagQRCodeError then
    begin
      BlocoTraduzido := '';
      ConfigQRCode.ErrorLevel := StrToIntDef( ConteudoBloco, ConfigQRCode.ErrorLevel);
    end

    else if ATag = cTagQRCode then
    begin
      BlocoTraduzido := FPosPrinterClass.ComandoQrCode(ConteudoBloco);
    end

    else if ATag = cTagBarraMostrar then
    begin
      BlocoTraduzido := '';
      ConfigBarras.MostrarCodigo := StrToBoolDef( ConteudoBloco, ConfigBarras.MostrarCodigo);
    end

    else if ATag = cTagBarraLargura then
    begin
      BlocoTraduzido := '';
      ConfigBarras.LarguraLinha := StrToIntDef( ConteudoBloco, ConfigBarras.LarguraLinha);
    end

    else if ATag = cTagBarraAltura then
    begin
      BlocoTraduzido := '';
      ConfigBarras.Altura := StrToIntDef( ConteudoBloco, ConfigBarras.Altura);
    end

    else if ATag = cTagLogoImprimir then
    begin
      BlocoTraduzido := '';
      ConfigLogo.IgnorarLogo := not StrToBoolDef( ConteudoBloco, not ConfigLogo.IgnorarLogo);
    end

    else if ATag = cTagLogoKC1 then
    begin
      BlocoTraduzido := '';
      ConfigLogo.KeyCode1 := StrToIntDef( ConteudoBloco, ConfigLogo.KeyCode1);
    end

    else if ATag = cTagLogoKC2 then
    begin
      BlocoTraduzido := '';
      ConfigLogo.KeyCode2 := StrToIntDef( ConteudoBloco, ConfigLogo.KeyCode2);
    end

    else if ATag = cTagLogoFatorX then
    begin
      BlocoTraduzido := '';
      ConfigLogo.FatorX := StrToIntDef( ConteudoBloco, ConfigLogo.FatorX);
    end

    else if ATag = cTagLogoFatorY then
    begin
      BlocoTraduzido := '';
      ConfigLogo.FatorY := StrToIntDef( ConteudoBloco, ConfigLogo.FatorY);
    end

    else if (AnsiIndexText(ATag, cTAGS_BARRAS) >= 0) then
    begin

      // Ajustando os C�digos de Barras, conforme regras do Tipo do C�digo //
      if (ATag = cTagBarraUPCA) then
        // Apenas n�meros, sempre 11 digitos, e 1 digito verificador
        ACodBar := PadLeft(OnlyNumber(ConteudoBloco), 11, '0')

      else if (ATag = cTagBarraUPCE) then
        // EPC-A compactado, Apenas n�meros, 6 ou 11 d�gitos
        ACodBar := OnlyNumber(ConteudoBloco)

      else if ATag = cTagBarraEAN13 then
        // Apenas n�meros, sempre 12 digitos, e 1 digito verificador
        ACodBar := PadLeft(OnlyNumber(ConteudoBloco), 12, '0')

      else if ATag = cTagBarraEAN8 then
        // Apenas n�meros, sempre 7 digitos, e 1 digito verificador
        ACodBar := PadLeft(OnlyNumber(ConteudoBloco), 7, '0')

      else if ATag = cTagBarraCode128c then
        // Apenas n�meros,
        ACodBar := OnlyNumber(ConteudoBloco)

      else if ATag = cTagBarraCode39 then
        // Qualquer tamanho.. Aceita: 0~9, A~Z, ' ', '$', '%', '*', '+', '-', '.', '/'
        ACodBar := OnlyCharsInSet(ConteudoBloco,
          ['0'..'9', 'A'..'Z', ' ', '$', '%', '*', '+', '-', '.', '/'])

      else if ATag = cTagBarraCode93 then
        // Qualquer tamanho.. Aceita: #0~#127
        ACodBar := OnlyCharsInSet(ConteudoBloco, [#0..#127])

      else if ATag = cTagBarraInter then
      begin
        // Interleaved 2of5. Somente n�meros, Tamanho deve ser PAR
        ACodBar := OnlyNumber(ConteudoBloco);

        if (Length(ACodBar) mod 2) <> 0 then  // Tamanho � Par ?
          ACodBar := '0' + ACodBar;
      end

      else if ATag = cTagBarraStd then
        // Apenas n�meros, Sem d�gito verificador
        ACodBar := OnlyNumber(ConteudoBloco)

      else if ATag = cTagBarraCodaBar then
        // Qualquer tamanho.. Aceita: 0~9, A~D, a~d, $, +, -, ., /, :
        ACodBar := OnlyCharsInSet(ConteudoBloco,
          ['0'..'9', 'A'..'D', 'a'..'d', '$', '+', '-', '.', '/', ':'])

      else if ATag = cTagBarraCode11 then
        // Apenas n�meros, Qualquer tamanho, dois d�gitos verificador
        ACodBar := OnlyNumber(ConteudoBloco)

      else if ATag = cTagBarraMSI then
        // Apenas n�meros, 1 d�gito verificador
        ACodBar := OnlyNumber(ConteudoBloco)

      else
        ACodBar := ConteudoBloco;

      ACodBar := LeftStr(ACodBar, 255);  // Tamanho m�ximo para Cod.Barras � 255 caracteres

      BlocoTraduzido := FPosPrinterClass.ComandoCodBarras(ATag, ACodBar);
    end;
  end;

  GravarLog('TraduzirTagBloco(' + ATag + ', ' + ConteudoBloco + ') -> ' + BlocoTraduzido, True);
end;

procedure TACBrPosPrinter.AtivarPorta;
begin
  if not FDevice.Ativo then
  begin
    GravarLog('Ativando a porta: ' + FDevice.Porta);
    FDevice.Ativar;
  end;
end;

procedure TACBrPosPrinter.DesativarPorta;
begin
  if FDevice.Ativo then
  begin
    GravarLog('Desativando a porta: ' + FDevice.Porta);

    FDevice.Desativar;

    if not FDevice.IsSerialPort then
      FInicializada := False;
  end;
end;

procedure TACBrPosPrinter.EnviarStringDevice(AString: AnsiString);
var
  CmdInit: AnsiString;
  Tratado:boolean;
begin
  if AString = '' then
    exit;

  AtivarPorta;

  if not FInicializada then
  begin
    CmdInit := FPosPrinterClass.ComandoInicializa;
    FInicializada := (pos( CmdInit, AString ) > 0);

    if (not FInicializada) and (AString <> FPosPrinterClass.Cmd.Zera) then
    begin
      GravarLog('EnviarStringDevice - Inicializando: '+CmdInit, True);
      AString := CmdInit + AString;
      FInicializada := True;
    end;
  end;

  Tratado := False;
  if Assigned(FOnEnviarStringDevice) then
     FOnEnviarStringDevice(AString, Tratado);

  try
    if not Tratado then
    begin
      GravarLog('EnviarStringDevice( ' + AString + ')', True);
      FDevice.EnviaString(AString);
    end
    else
      GravarLog('OnEnviarStringDevice( ' + AString + ')', True);
  finally
    if ControlePorta then
      DesativarPorta;
  end;
end;

procedure TACBrPosPrinter.GravarLog(AString: AnsiString; Traduz: Boolean;
  AdicionaTempo: Boolean);
var
  Tratado: Boolean;
begin
  Tratado := False;

  if Traduz then
    AString := TranslateUnprintable(AString);

  if Assigned(FOnGravarLog) then
    FOnGravarLog(AString, Tratado);

  if not Tratado then
  begin
    if AdicionaTempo then
      AString := '-- ' + FormatDateTime('dd/mm hh:nn:ss:zzz', now) + ' - ' + AString;

    WriteLog(FArqLog, AString);
  end;
end;

procedure TACBrPosPrinter.RetornarTags(AStringList: TStrings;
  IncluiAjuda: Boolean);
begin
  FTagProcessor.RetornarTags(AStringList, IncluiAjuda);
end;

procedure TACBrPosPrinter.ImprimirTags;
begin
  FTagProcessor.RetornarTags(FBuffer);
  FBuffer.Insert(0,'</zera><c><ignorar_tags>');
  FBuffer.Add('</ignorar_tags>');
  FBuffer.Add('</corte_total>');

  Imprimir;
end;

function TACBrPosPrinter.TxRx(ACmd: AnsiString; BytesToRead: Byte;
  ATimeOut: Integer; WaitForTerminator: Boolean): AnsiString;
begin
  FDevice.Limpar;

  GravarLog('TX -> '+ACmd, True);
  FDevice.EnviaString( ACmd );

  Sleep(10);  // Aguarda equipamento ficar pronto para responder

  if WaitForTerminator then
    Result := FDevice.LeString(ATimeOut, 0, chr(BytesToRead))
  else
    Result := FDevice.LeString(ATimeOut, BytesToRead);

  GravarLog('RX <- '+Result, True);
end;

function TACBrPosPrinter.GetIgnorarTags: Boolean;
begin
  Result := FTagProcessor.IgnorarTags;
end;

function TACBrPosPrinter.GetPorta: String;
begin
  Result := FDevice.Porta;
end;

function TACBrPosPrinter.GetTagsNaoSuportadas: TStringList;
begin
  Result := FPosPrinterClass.TagsNaoSuportadas;
end;

function TACBrPosPrinter.LerStatusImpressora: TACBrPosPrinterStatus;
var
  OldAtivo: Boolean;
begin
  Result := [];

  OldAtivo := Ativo;
  try
    Ativo := True;

    if not (FDevice.IsSerialPort or FDevice.IsTCPPort) then
      Result := Result + [stNaoSerial];

    if Result = [] then
    begin
      FPosPrinterClass.LerStatus( Result );

      if ConfigGaveta.SinalInvertido then
      begin
        if (stGavetaAberta in Result) then
          Result := Result - [stGavetaAberta]
        else
          Result := Result + [stGavetaAberta];
      end;
    end;
  finally
    Ativo := OldAtivo;
  end;
end;

function TACBrPosPrinter.LerInfoImpressora: String;
var
  OldAtivo: Boolean;
begin
  Result := '';

  OldAtivo := Ativo;
  try
    Ativo := True;

    if not (FDevice.IsSerialPort or FDevice.IsTCPPort) then
      raise EPosPrinterException.Create(ACBrStr('Leitura de Informa��es s� disponivel em Portas Seriais ou TCP'));

    Result := FPosPrinterClass.LerInfo;
  finally
    Ativo := OldAtivo;
  end;
end;

function TACBrPosPrinter.GetTraduzirTags: Boolean;
begin
  Result := FTagProcessor.TraduzirTags;
end;

procedure TACBrPosPrinter.SetAtivo(AValue: Boolean);
begin
  if AValue then
    FDevice.Ativar
  else
    FDevice.Desativar;
end;

procedure TACBrPosPrinter.SetIgnorarTags(AValue: Boolean);
begin
  FTagProcessor.IgnorarTags := AValue;
end;

procedure TACBrPosPrinter.SetPorta(AValue: String);
begin
  FDevice.Porta := AValue;
end;

procedure TACBrPosPrinter.SetTraduzirTags(AValue: Boolean);
begin
  FTagProcessor.TraduzirTags := AValue;
end;

procedure TACBrPosPrinter.Imprimir(AString: AnsiString; PulaLinha: Boolean;
  DecodificarTags: Boolean; CodificarPagina: Boolean; Copias: Integer);
var
  i: Integer;
  StrToPrint: AnsiString;
  PrnStatus: TACBrPosPrinterStatus;
  MsgErro: String;
begin
  try
    if not (ControlePorta or FDevice.Ativo) then
      raise EPosPrinterException.Create(ACBrStr('N�o est� Ativo'));

    if not Ativo then
      Ativar;

    if VerificarImpressora then
    begin
      MsgErro := '';
      PrnStatus := LerStatusImpressora;

      if stTampaAberta in PrnStatus then
        MsgErro := 'com Tampa Aberta'
      else if stSemPapel in PrnStatus then
        MsgErro := 'Sem Papel'
      else if stOffLine in PrnStatus then
        MsgErro := 'Desligada'
      else if stErro in PrnStatus then
        MsgErro := 'em Erro';

      if (MsgErro <> '') then
        raise EPosPrinterException.Create('Impressora '+MsgErro);
    end;

    StrToPrint := '';
    if (FBuffer.Count > 0) then
    begin
      For i := 0 to FBuffer.Count-1 do
        StrToPrint := StrToPrint + FBuffer[i] + FPosPrinterClass.Cmd.PuloDeLinha;
    end;
  finally
    FBuffer.Clear;
  end;

  StrToPrint := StrToPrint + AString;

  GravarLog('Imprimir, Copias:' + IntToStr(Copias)+
            ', DecodificarTags:'+IfThen(DecodificarTags,'SIM','NAO')+
            ', TraduzirTags:'+IfThen(TraduzirTags,'SIM','NAO') );
  GravarLog( TranslateUnprintable(StrToPrint) );

  if CodificarPagina then
    StrToPrint := CodificarPaginaDeCodigo(StrToPrint);

  //DEBUG
  //WriteLog('c:\temp\teste2.txt', StrToPrint, True);

  StrToPrint := ChangeLineBreak(StrToPrint, FPosPrinterClass.Cmd.PuloDeLinha);

  if DecodificarTags then
    StrToPrint := FTagProcessor.DecodificarTagsFormatacao(StrToPrint);

  if PulaLinha then
    StrToPrint := StrToPrint + FPosPrinterClass.Cmd.PuloDeLinha;

  //DEBUG
  //WriteLog('c:\temp\teste3.txt', StrToPrint, True);

  For i := 1 to Copias do
    EnviarStringDevice(StrToPrint);
end;

procedure TACBrPosPrinter.ImprimirLinha(AString: AnsiString);
begin
  Imprimir(AString, True);
end;

procedure TACBrPosPrinter.ImprimirCmd(AString: AnsiString);
begin
  if FBuffer.Count > 0 then
    Imprimir;

  if AString = '' then
    exit;

  EnviarStringDevice(AString);
end;

procedure TACBrPosPrinter.Zerar;
begin
  GravarLog('Zerar');
  ImprimirCmd(FPosPrinterClass.Cmd.Zera);

  FInicializada := False;
  FFonteStatus := FFonteStatus - [ftCondensado, ftExpandido, ftNegrito,
      ftSublinhado, ftItalico, ftInvertido];

  Inicializar;
end;

procedure TACBrPosPrinter.Inicializar;
begin
  GravarLog('Inicializar');
  ImprimirCmd(FPosPrinterClass.ComandoInicializa);

  FInicializada := True;
end;

function TACBrPosPrinter.GetNumeroPaginaDeCodigo(APagCod: TACBrPosPaginaCodigo): word;
begin
  case APagCod of
    pc437: Result := 437;
    pc850: Result := 850;
    pc852: Result := 852;
    pc860: Result := 860;
    pc1252: Result := 1252;
    pcUTF8: Result := 65001;
    else
      Result := 0;
  end;
end;

function TACBrPosPrinter.GetAtivo: Boolean;
begin
  Result := FDevice.Ativo;
end;

function TACBrPosPrinter.CodificarPaginaDeCodigo(ATexto: AnsiString
  ): AnsiString;
var
  NumPagCod: word;
begin
  NumPagCod := GetNumeroPaginaDeCodigo(FPaginaDeCodigo);
  //GravarLog('CodificarPaginaDeCodigo: '+IntToStr(NumPagCod) );

  if NumPagCod > 0 then
  begin
    {$IfDef MSWINDOWS}
    Result := TranslateString(ACBrStrToAnsi(ATexto), NumPagCod)
    {$Else}
    Result := TranslateString(ATexto, NumPagCod)
    {$EndIf}
  end
  else
    Result := TiraAcentos(ATexto);
end;

procedure TACBrPosPrinter.PularLinhas(NumLinhas: Integer);
begin
  GravarLog('PularLinhas(' + IntToStr(NumLinhas) + ')');

  if NumLinhas = 0 then
    NumLinhas := LinhasEntreCupons;

  ImprimirCmd( FPosPrinterClass.ComandoPuloLinhas(NumLinhas) );
end;

procedure TACBrPosPrinter.CortarPapel(Parcial: Boolean);
begin
  GravarLog('CortarPapel(' + IfThen(Parcial, 'Parcial', 'Total') + ')');

  if Parcial then
    ImprimirCmd(FPosPrinterClass.Cmd.CorteParcial)
  else
    ImprimirCmd(FPosPrinterClass.Cmd.CorteTotal);

  Sleep(500);
end;

end.


unit wbDefinitionsCommon;

{$I wbDefines.inc}

interface

uses
  wbInterface;

const
  SCDA : TwbSignature = 'SCDA';
  SCTX : TwbSignature = 'SCTX';

var
  wbActionFlag: IwbSubRecordDef;
  wbAlternateTexture: IwbValueDef;
  wbAxisEnum: IwbEnumDef;
  wbCellGrid: IwbRecordMemberDef;
  wbCinematicIMAD: IwbSubRecordStructDef;
  wbColorInterpolator: IwbStructDef;
  wbDATAPosRot: IwbSubRecordDef;
  wbFaction: IwbRecordMemberDef;
  wbFactionRelations: IwbRecordMemberDef;
  wbHEDR: IwbSubRecordDef;
  wbMDOB: IwbSubRecordDef;
  wbNextSpeaker: IwbIntegerDef;
  wbPosRot: IwbStructDef;
  wbQuadrantEnum: IwbEnumDef;
  wbSeasons: IwbRecordMemberDef;
  wbSexEnum: IwbEnumDef;
  wbTimeInterpolator: IwbStructDef;
  wbVertexHeightMap: IwbRecordMemberDef;
  wbWorldspaceOBND: IwbRecordMemberDef;
  wbXLOD: IwbSubRecordDef;

procedure DefineCommon;

{>>> Common Procedure Callbacks <<<}

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

{>>> Common Summary Callbacks <<<}

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbLeveledListEntryToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbRecordHeaderToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbScriptToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

{>>> Common Function Callbacks <<<}

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function wbCTDAParam2QuestObjectiveToInt(const aString: string; const aElement: IwbElement): Int64;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbMODTCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function wbNeverShow(const aElement: IwbElement): Boolean;

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

{>>> Common Definitions <<<}

function wbClimateTiming(aTimeCallback: TwbIntToStrCallback; aPhaseCallback: TwbIntToStrCallback): IwbRecordMemberDef;

function wbCNAM(aRequired: Boolean = False): IwbRecordMemberDef;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;

function wbLandscapeLayers(aSimpleRecords: Boolean = True): IwbRecordMemberDef;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;

function wbOwnership(aOwner: IwbSubRecordDef; aSkipSigs: TwbSignatures; aGlobal: IwbSubRecordDef = nil): IwbRecordMemberDef;

function wbPerkEffectType(aAfterSetCallback: TwbAfterSetCallback): IwbIntegerDef;

function wbSizePosRot(aSignature: TwbSignature; aName: string; aPriority: TwbConflictPriority = cpNormal): IwbSubRecordDef;

function wbVertexColumns(aSignature: TwbSignature; aName: string): IwbRecordMemberDef;

{>>> Common Functions <<<}

function Sig2Int(aSignature: TwbSignature): Cardinal; inline;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;

function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;

function wbTryGetMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord; aSignature: string = ''): Boolean;

implementation

uses
  Classes,
  Math,
  StrUtils,
  SysUtils;

const
  _11_IAD: TwbSignature = #$11'IAD';
  _51_IAD: TwbSignature = #$51'IAD';
  _12_IAD: TwbSignature = #$12'IAD';
  _52_IAD: TwbSignature = #$52'IAD';
  _13_IAD: TwbSignature = #$13'IAD';
  _53_IAD: TwbSignature = #$53'IAD';
  NULL: TwbSignature = 'NULL';
  ATXT: TwbSignature = 'ATXT';
  BTXT: TwbSignature = 'BTXT';
  CNAM: TwbSignature = 'CNAM';
  CTDA: TwbSignature = 'CTDA';
  DATA: TwbSignature = 'DATA';
  FACT: TwbSignature = 'FACT';
  GLOB: TwbSignature = 'GLOB';
  HEDR: TwbSignature = 'HEDR';
  LTEX: TwbSignature = 'LTEX';
  MDOB: TwbSignature = 'MDOB';
  MODT: TwbSignature = 'MODT';
  NAM0: TwbSignature = 'NAM0';
  NAM9: TwbSignature = 'NAM9';
  OBND: TwbSignature = 'OBND';
  PFPC: TwbSignature = 'PFPC';
  RACE: TwbSignature = 'RACE';
  SNAM: TwbSignature = 'SNAM';
  TNAM: TwbSignature = 'TNAM';
  TXST: TwbSignature = 'TXST';
  VCLR: TwbSignature = 'VCLR';
  VHGT: TwbSignature = 'VHGT';
  VNML: TwbSignature = 'VNML';
  VTXT: TwbSignature = 'VTXT';
  XACT: TwbSignature = 'XACT';
  XCLC: TwbSignature = 'XCLC';
  XGLB: TwbSignature = 'XGLB';
  XLOD: TwbSignature = 'XLOD';
  XNAM: TwbSignature = 'XNAM';
  XRNK: TwbSignature = 'XRNK';

function IfThen(aBoolean: Boolean; const aTrue: IwbRecordMemberDef; const aFalse: IwbRecordMemberDef): IwbRecordMemberDef; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

function IfThen(aBoolean: Boolean; const aTrue: IwbValueDef; const aFalse: IwbValueDef): IwbValueDef; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

procedure DefineCommon;
begin
  wbHEDR :=
    wbStruct(HEDR, 'Header', [
      wbFloat('Version'),
      wbInteger('Number of Records', itU32),
      wbInteger('Next Object ID', itU32, wbNextObjectIDToString, wbNextObjectIDToInt)
    ], cpNormal, True);

  wbColorInterpolator :=
    wbStructSK([0], 'Data', [
      wbFloat('Time'),
      wbFloat('Red', cpNormal, False, 255, 0),
      wbFloat('Green', cpNormal, False, 255, 0),
      wbFloat('Blue', cpNormal, False, 255, 0),
      wbFloat('Alpha', cpNormal, False, 255, 0)
    ]);

  wbTimeInterpolator :=
    wbStructSK([0], 'Data', [
      wbFloat('Time'),
      wbFloat('Value')
    ]);

  wbActionFlag :=
    wbInteger(XACT, 'Action Flag', itU32, wbFlags([
      'Use Default',
      'Activate',
      'Open',
      'Open by Default'
    ]));

  wbAlternateTexture :=
    wbStructSK([0, 2], 'Alternate Texture', [
      wbLenString('3D Name'),
      wbFormIDCk('New Texture', [TXST]),
      wbInteger('3D Index', itS32)
    ])
    .SetSummaryKey([2, 0, 1])
    .SetSummaryMemberPrefixSuffix(2, '[', ']')
    .SetSummaryMemberPrefixSuffix(0, '', ' =')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  wbCellGrid :=
    wbStruct(XCLC, 'Grid', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32),
      wbInteger('Force Hide Land', itU32, wbFlags([
        'Quad 1',
        'Quad 2',
        'Quad 3',
        'Quad 4'
      ], True))
    ], cpNormal, False, nil, 2)
    .SetSummaryKeyOnValue([0, 1, 2])
    .SetSummaryPrefixSuffixOnValue(0, '(', '')
    .SetSummaryPrefixSuffixOnValue(1, '', ')')
    .SetSummaryPrefixSuffixOnValue(2, ' {Force Hide Land: ', '}')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed);

  wbCinematicIMAD :=
    wbRStruct('Cinematic', [
      wbArray(_11_IAD, 'Saturation Mult', wbTimeInterpolator),
      wbArray(_51_IAD, 'Saturation Add', wbTimeInterpolator),
      wbArray(_12_IAD, 'Brightness Mult', wbTimeInterpolator),
      wbArray(_52_IAD, 'Brightness Add', wbTimeInterpolator),
      wbArray(_13_IAD, 'Contrast Mult', wbTimeInterpolator),
      wbArray(_53_IAD, 'Contrast Add', wbTimeInterpolator)
    ], []);

  wbDATAPosRot :=
    wbStruct(DATA, 'Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3),

      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3)
    ], cpNormal, True);

  wbFaction :=
    wbStructSK(SNAM, [0], 'Faction', [
      wbFormIDCk('Faction', [FACT]),
      wbInteger('Rank', itU8),
      IfThen(wbGameMode in [gmFO4, gmFO76], nil, wbByteArray('Unused', 3))
    ])
    .SetSummaryKeyOnValue([0, 1])
    .SetSummaryPrefixSuffixOnValue(1, '{Rank: ', '}')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseFactions);

  wbFactionRelations :=
    wbRArrayS('Relations',
      wbStructSK(XNAM, [0], 'Relation', [
        wbFormIDCkNoReach('Faction', [FACT, RACE]),
        wbInteger('Modifier', itS32),
        IfThen(wbGameMode = gmTES4,
          nil,
          wbInteger('Group Combat Reaction', itU32, wbEnum([
            {0x00000001} 'Neutral',
            {0x00000002} 'Enemy',
            {0x00000004} 'Ally',
            {0x00000008} 'Friend'
          ])))
      ])
      .SetToStr(wbFactionRelationToStr)
      .IncludeFlag(dfCollapsed, wbCollapseFactionRelations));

  wbMDOB := wbFormID(MDOB, 'Menu Display Object', cpNormal, False);

  wbNextSpeaker :=
    wbInteger('Next Speaker', itU8, wbEnum([
      {0} 'Target',
      {1} 'Self',
      {2} 'Either'
    ]));  wbPosRot :=    wbStruct('Position/Rotation', [
      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3),

      wbStruct('Rotation', [
        wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3)
    ]);

  wbQuadrantEnum :=
    wbEnum([
      {0} 'Bottom Left',
      {1} 'Bottom Right',
      {2} 'Top Left',
      {3} 'Top Right'
    ]);

  wbSeasons :=
    wbStruct(PFPC, 'Seasonal ingredient production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True);

  wbSexEnum :=
    wbEnum(['Male','Female']);

  wbVertexHeightMap :=
    wbStruct(VHGT, 'Vertex Height Map', [
      wbFloat('Offset'),
      wbArray('Rows', wbStruct('Row', [
        wbArray('Columns', wbInteger('Column', itU8), 33)
      ]), 33),
      wbByteArray('Unused', 3)
    ]);

  wbWorldspaceOBND :=
    wbRStruct('Object Bounds', [
      wbStruct(NAM0, 'Min', [
        wbFloat('X', cpNormal, False, 1/4096),
        wbFloat('Y', cpNormal, False, 1/4096)
      ], cpIgnore, True)
      .SetSummaryKeyOnValue([0, 1])
      .SetSummaryPrefixSuffixOnValue(0, 'Min(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseObjectBounds),
      wbStruct(NAM9, 'Max', [
        wbFloat('X', cpNormal, False, 1/4096),
        wbFloat('Y', cpNormal, False, 1/4096)
      ], cpIgnore, True)
      .SetSummaryKeyOnValue([0, 1])
      .SetSummaryPrefixSuffixOnValue(0, 'Max(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseObjectBounds)
    ], [])
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(0, '[', '')
    .SetSummaryMemberPrefixSuffix(1, '', ']')
    .SetSummaryDelimiter(', ')
    .IncludeFlag(dfCollapsed, wbCollapseObjectBounds);

  wbXLOD := wbArray(XLOD, 'Distant LOD Data', wbFloat('Unknown'), 3);
end;

function Sig2Int(aSignature: TwbSignature): Cardinal; inline;
begin
  Result := PCardinal(@aSignature)^;
end;

{>>> Common Callbacks <<<}

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';

  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt div 17, 2) + IntToHex64(aInt mod 17, 2);
    Exit;
  end;

  if aType = ctCheck then begin
    if (aInt < 0) or (aInt > 288) then
      Result := '<Out of range: '+aInt.ToString+'>'
    else
      Exit;
  end;

  if aType in [ctToStr, ctToSummary] then
    Result := aInt.ToString + ' -> ' + IntToStr(aInt div 17) + ':' + IntToStr(aInt mod 17);
end;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if wbGameMode = gmFNV then begin
    // IsFacingUp, IsLeftUp
    var i := Container.ElementNativeValues['Function'];
    if (i = 106) or (i = 285) then
      Exit;
  end;

  if Integer(Container.ElementNativeValues['Run On']) = 2 then
    Result := 1;
end;

function wbCTDAParam2QuestObjectiveToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if aOldValue <> aNewValue then
    if aNewValue <> 2 then
      aElement.Container.ElementNativeValues['Reference'] := 0;
end;

function wbMODTCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Strings: TDynStrings;
  i: Integer;
begin
  Result := '';
  if wbLoaderDone and (aType in [ctToStr, ctToSummary, ctToSortKey] ) then begin
    Strings := wbContainerHandler.ResolveHash(aInt);
    for i := Low(Strings) to High(Strings) do
      Result := Result + Strings[i] + ', ';
    SetLength(Result, Length(Result) -2 );
  end;
  if Result = '' then
    Result := 'Unresolved: ' + IntToHex64(aInt, 16);
end;

function wbNeverShow(const aElement: IwbElement): Boolean;
begin
  Result := wbHideNeverShow;
end;

{>>> Common Definitions <<<}

function wbClimateTiming(aTimeCallback: TwbIntToStrCallback; aPhaseCallback: TwbIntToStrCallback): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(TNAM, 'Timing', [
      wbStruct('Sunrise', [
        wbInteger('Begin', itU8, aTimeCallback),
        wbInteger('End', itU8, aTimeCallback)
      ]),
      wbStruct('Sunset', [
        wbInteger('Begin', itU8, aTimeCallback),
        wbInteger('End', itU8, aTimeCallback)
      ]),
      wbInteger('Volatility', itU8),
      wbInteger('Moons / Phase Length', itU8, aPhaseCallback)
    ], cpNormal, True);
end;

function wbCNAM(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(CNAM, 'Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unknown', 1)
    ], cpNormal, aRequired)
    .SetToStr(wbRGBAToStr)
    .IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;
begin
  Result :=
    wbRStruct('Model', [
      wbStruct(DATA, 'Data', [
        wbInteger('Percentage', itU8),
        wbString('Model FileName'),
        wbInteger('Flags', itU8, wbFlagsSummary([
          'Has Collision Data', 'Collision'
        ]))
      ], cpNormal, True)
      .SetSummaryKeyOnValue([0, 1, 2])
      .SetSummaryPrefixSuffixOnValue(0, '[', '%]')
      .SetSummaryPrefixSuffixOnValue(2, '{', '}')
      .SetSummaryMemberMaxDepthOnValue(0, 1)
      .IncludeFlagOnValue(dfSummaryMembersNoName),
      aTextureFileHashes
    ], [], cpNormal, True)
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels);
end;

function wbLandscapeLayers(aSimpleRecords: Boolean = True): IwbRecordMemberDef;
var
  alphaLayerData: IwbSubRecordDef;
begin
  if aSimpleRecords then
    alphaLayerData := wbByteArray(VTXT, 'Alpha Layer Data')
  else
    alphaLayerData :=
      wbArrayS(VTXT, 'Alpha Layer Data', wbStructSK([0], 'Cell', [
        wbInteger('Position', itU16, wbAtxtPosition),
        wbByteArray('Unused', 2),
        wbFloat('Opacity')
      ]));

  Result :=
    wbRArrayS('Layers', wbRUnion('Layer', [
      wbRStructSK([0],'Base Layer', [
        wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
          wbFormIDCk('Texture', [LTEX, NULL]),
          wbInteger('Quadrant', itU8, wbQuadrantEnum),
          wbByteArray('Unused', 1),
          wbInteger('Layer', itS16)
        ])
      ], []),
      wbRStructSK([0],'Alpha Layer', [
        wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
          wbFormIDCk('Texture', [LTEX, NULL]),
          wbInteger('Quadrant', itU8, wbQuadrantEnum),
          wbByteArray('Unused', 1),
          wbInteger('Layer', itS16)
        ]),
        alphaLayerData
      ], [])
    ], []));
end;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(OBND, 'Object Bounds', [
      wbInteger('X1', itS16),
      wbInteger('Y1', itS16),
      wbInteger('Z1', itS16),
      wbInteger('X2', itS16),
      wbInteger('Y2', itS16),
      wbInteger('Z2', itS16)
    ], cpNormal, aRequired)
    .SetSummaryKeyOnValue([0, 1, 2, 3, 4, 5])
    .SetSummaryPrefixSuffixOnValue(0, '(', '')
    .SetSummaryPrefixSuffixOnValue(2, '', ')')
    .SetSummaryPrefixSuffixOnValue(3, '(', '')
    .SetSummaryPrefixSuffixOnValue(5, '', ')')
    .SetSummaryDelimiterOnValue(', ')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseObjectBounds);
end;

function wbOwnership(aOwner: IwbSubRecordDef; aSkipSigs: TwbSignatures; aGlobal: IwbSubRecordDef = nil): IwbRecordMemberDef;
begin
  Result :=
    wbRStruct('Ownership', [
      aOwner,
      wbInteger(XRNK, 'Faction rank', itS32),
      IfThen(wbGameMode = gmTES4, aGlobal, nil)
    ], aSkipSigs)
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(1, '{Rank: ', '}')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseFactions);
end;

function wbPerkEffectType(aAfterSetCallback: TwbAfterSetCallback): IwbIntegerDef;
begin
  Result :=
    wbInteger('Type', itU8, wbEnum([
      'Quest + Stage',
      'Ability',
      'Entry Point'
    ]), cpNormal, False, nil, aAfterSetCallback);
end;

function wbSizePosRot(aSignature: TwbSignature; aName: string; aPriority: TwbConflictPriority = cpNormal): IwbSubRecordDef;
begin
  Result :=
    wbStruct(aSignature, aName, [
      wbStruct('Size', [
        wbFloat('Width', cpNormal, False, 2),
        wbFloat('Height', cpNormal, False, 2)
      ])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, 'Size(', '')
      .SetSummaryMemberPrefixSuffix(1, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed),

      wbStruct('Position', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3),

      wbStruct('Rotation (Quaternion?)', [
        wbFloat('q1'),
        wbFloat('q2'),
        wbFloat('q3'),
        wbFloat('q4')
      ])
      .SetSummaryKey([0, 1, 2, 3])
      .SetSummaryMemberPrefixSuffix(0, 'Quat(', '')
      .SetSummaryMemberPrefixSuffix(3, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    ], aPriority);
end;

function wbVertexColumns(aSignature: TwbSignature; aName: string): IwbRecordMemberDef;
begin
  Result :=
    wbArray(aSignature, aName, wbStruct('Row', [
      wbArray('Columns', wbStruct('Column', [
        wbInteger('X', itU8),
        wbInteger('Y', itU8),
        wbInteger('Z', itU8)
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, 'Vec3(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3), 33)
    ]), 33);
end;

{>>> For Collapsible Fields <<<}

function wbTrySetContainer(const aElement: IwbElement; aType: TwbCallbackType; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := (aType = ctToSummary) and Supports(aElement, IwbContainerElementRef, aContainer);
end;

{>>> Common Functions <<<}

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerFromUnion(aElement);
  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord; aSignature: string = ''): Boolean;
var
  MainRecord: IwbMainRecord;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  if not SameText(aSignature, '') then
    if MainRecord.Signature <> aSignature then
      Exit;

  aMainRecord := MainRecord;
  Result := True;
end;

{>>> Common Callbacks <<<}

/// <summary>Generates "{Count}x {FormID}" string for item. Supports single and double structs.</summary>
/// <param name="aContainer">The Item element</param>
/// <returns>string</return>
function wbGetItemStr(const aContainer: IwbContainerElementRef): string;
var
  MainRecord: IwbMainRecord;
begin
  Result := '';

  var FormID := aContainer.Elements[0];
  if not wbTryGetMainRecord(FormID, MainRecord) then
    Exit;

  var Count := aContainer.Elements[1];

  Result := Count.Value + 'x ' + MainRecord.ShortName;
end;

/// <summary>Returns Object Format version of Object Union. Corresponds to index of wbStructSK in Object Union array.</summary>
/// <param name="aElement">The Object Union element</param>
/// <returns>0 = Object v2, 1 = Object v1</returns>
function wbGetScriptObjFormat(const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etSubRecord) do
    Container := Container.Container;

  if Container = nil then
    Exit;

  var ObjFormat := Container.ElementNativeValues['Object Format'];

  if ObjFormat = 1 then
    Result := 1;
end;

/// <summary>Generates comma-delimited list of array values for an array-type property</summary>
/// <param name="aContainer">The Array Value element (e.g., "Value\Array of Object")</param>
/// <returns>string from TStringList.CommaText</returns>
function wbGetPropertyValueArrayItems(const aContainer: IwbContainerElementRef): string;
var
  MainRecord: IwbMainRecord;
  ItemName: string;
begin
  var Items := TStringList.Create;

  if CompareStr(aContainer.Name, 'Array of Object') = 0 then
    for var i := 0 to Pred(aContainer.ElementCount) do begin
      var ObjectUnion := aContainer.Elements[i] as IwbContainerElementRef;
      var ObjectVersion := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

      var FormID := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\FormID'];
      var Alias := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\Alias'];
      var AliasValue := Alias.Value;

      if Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
        if MainRecord <> nil then
          ItemName := MainRecord.ShortName
        else
          ItemName := 'NULL';

      if not (CompareStr(AliasValue, 'None') = 0) and not (Length(AliasValue) = 0) then
        Items.Add(Alias.EditValue + IfThen(Length(ItemName) > 0, ' = ' + ItemName, ''))
      else
        if MainRecord <> nil then
          Items.Add(MainRecord.ShortName)
        else
          Items.Add('NULL');
    end
  else
    for var i := 0 to Pred(aContainer.ElementCount) do
      Items.Add(aContainer.Elements[i].Value);

  Result := Items.CommaText;
  Items.Free;
end;

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  cerCTDA: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if wbGameMode > gmFNV then begin
    if not Supports(Container.RecordBySignature[CTDA], IwbContainerElementRef, cerCTDA) then
      Exit;
  end else
    cerCTDA := Container;

  var Typ : Byte := cerCTDA.Elements[0].NativeValue;
  var Func := cerCTDA.Elements[3];

  if (cerCTDA.ElementCount >= 9)
  and (cerCTDA.Elements[7].Def.DefType <> dtEmpty)
  and (cerCTDA.Elements[8].Def.DefType <> dtEmpty) then begin
    var RunOn := cerCTDA.Elements[7];

    var RunOnInt: Integer := RunOn.NativeValue;

    if wbGameMode = gmFNV then begin
      var FuncInt: Integer := Func.NativeValue;
      if (FuncInt = 106) or (FuncInt = 285) then
        RunOnInt := 0;
    end;

    if RunOnInt = 2 then
      aValue := '(' + cerCTDA.Elements[8].Summary + ')'
    else
      aValue := RunOn.Summary.Replace(' ', '', [rfReplaceAll]);
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Func.Summary;

  var Param1 := cerCTDA.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Summary;

    var Param2 := cerCTDA.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Summary;

    aValue := aValue + ')';
  end;

  case Typ and $E0 of
    $00: aValue := aValue + ' = ';
    $20: aValue := aValue + ' <> ';
    $40: aValue := aValue + ' > ';
    $60: aValue := aValue + ' >= ';
    $80: aValue := aValue + ' < ';
    $A0: aValue := aValue + ' <= ';
  end;

  aValue := aValue + cerCTDA.Elements[2].Summary;

  var Conditions: IwbContainerElementRef;
  if Supports(Container.Container, IwbContainerElementRef, Conditions) then
  begin
    var l := Conditions.ElementCount;
    if (l < 2) or Container.Equals(Conditions.Elements[Pred(l)]) then
      Exit;
  end;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  var Rank := Container.Elements[1];

  aValue := Faction.Value;

  if wbGameMode = gmTES4 then begin
    var NativeRank := Rank.NativeValue;

    aValue := IntToStr(NativeRank) + ' ' + aValue;

    if NativeRank >= 0 then
      aValue := '+' + aValue;

    Exit;
  end;

  aValue := Container.Elements[2].Value + ' ' + aValue;
end;

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var ActorValueForm := Container.ElementByName['Actor Value'];
  if not wbTryGetMainRecord(ActorValueForm, MainRecord) then
    Exit;

  var ActorValueData := Container.ElementByName['Value'];

  aValue := MainRecord.EditorID + ' = ' + Format('%.*g', [5, StrToFloat(ActorValueData.Value)]);

  if wbGameMode <> gmFO76 then
    Exit;

  var CurveTable := Container.ElementByName['Curve Table'] as IwbContainerElementRef;
  if not Assigned(CurveTable) then
    Exit;

  var CurveTableForm := CurveTable.ElementByName['Curve Table'];
  if not wbTryGetMainRecord(CurveTableForm, MainRecord) then
    Exit;

  aValue := aValue + ' {Curve Table: ' + MainRecord.ShortName + '}';
end;

procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  ItemString: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  // check for second struct
  if Container.Elements[0].ElementType = etSubRecord then
    Container := Container.Elements[0] as IwbContainerElementRef;

  ItemString := wbGetItemStr(Container);

  if Length(ItemString) = 0 then
    Exit;

  aValue := ItemString;
end;

procedure wbLeveledListEntryToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container, LeveledObject: IwbContainerElementRef; // Leveled List Entry
  Level, Ref, Count, ChanceNone: IwbElement;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  LeveledObject := Container.ElementBySignature['LVLO'] as IwbContainerElementRef;
  if Assigned(LeveledObject) then
    Container := LeveledObject;

  Ref := Container.ElementByName['Reference'];
  if not wbTryGetMainRecord(Ref, MainRecord) then
    Exit;

  Level := Container.ElementByName['Level'];
  Count := Container.ElementByName['Count'];

  // Fallout Only
  ChanceNone := Container.ElementByName['Chance None'];

  aValue := '[Lv' + Level.Value + '] ' + Count.Value + 'x ' + MainRecord.ShortName;

  if Assigned(ChanceNone) and (ChanceNone.NativeValue > 0) then
    aValue := aValue + ' {Chance None: ' + IntToStr(ChanceNone.NativeValue) + '%}';
end;

procedure wbRecordHeaderToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  RecordFlags, FormVersion: IwbElement;
  MainRecord: IwbMainRecord;
  RecordFlagsValue, DisplayValue: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  MainRecord := Container.ContainingMainRecord;
  RecordFlags := Container.ElementByName['Record Flags'];
  FormVersion := Container.ElementByName['Form Version'];

  RecordFlagsValue := RecordFlags.Value;

  DisplayValue := '[' + MainRecord.Signature + ':' + MainRecord.LoadOrderFormID.ToString(True) + ']';

  aValue := DisplayValue;

  if wbGameMode <> gmTES4 then
    aValue := '[v' + FormVersion.Value + '] ' + aValue;

  if Length(RecordFlagsValue) > 0 then
    aValue := aValue + ' {' + RecordFlagsValue + '}';
end;

/// <summary>Fills PropertyType and PropertyValue from array assigned to property</summary>
procedure wbScriptPropertyArrayToStr(const aContainer: IwbContainerElementRef; var PropertyType: string; var PropertyValue: string);
begin
  var ArrayContainer := aContainer.ElementByPath['Value\' + PropertyType] as IwbContainerElementRef;

  if not (ArrayContainer.ElementCount > 0) then
    Exit;

  PropertyValue := wbGetPropertyValueArrayItems(ArrayContainer);
  PropertyType := PropertyType.Substring(9) + '[]';
end;

/// <summary>Fills PropertyName, PropertyType, and PropertyName from object assigned to property</summary>
procedure wbScriptPropertyObjectToStr(const aContainer: IwbContainerElementRef; var PropertyName: string; var PropertyType: string; var PropertyValue: string);
var
  MainRecord: IwbMainRecord;
begin
  PropertyValue := 'NULL';

  var ObjectUnion := aContainer.ElementByPath['Value\Object Union'] as IwbContainerElementRef;

  var Version := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

  var FormID := ObjectUnion.ElementByPath['Object ' + Version + '\FormID'];
  var Alias := ObjectUnion.ElementByPath['Object ' + Version + '\Alias'];

  var AliasValue := Alias.Value;

  // compare length, too, because v1 doesn't default to 'None'
  if not (CompareStr(AliasValue, 'None') = 0) and not (Length(AliasValue) = 0) then begin
    PropertyType := 'Alias';
    PropertyName := Alias.EditValue;
  end;

  if not wbTryGetMainRecord(FormID, MainRecord) then
    Exit;

  PropertyValue := MainRecord.ShortName
end;

procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  PropertyValue: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var PropertyTypeElement := Container.ElementByName['Type'];

  // 0 = None
  if PropertyTypeElement.NativeValue = 0 then
    Exit;

  var PropertyName := Container.ElementByName['propertyName'].Value;

  if Length(PropertyName) = 0 then
    Exit;

  var PropertyType := PropertyTypeElement.Value;

  // 1 = Object
  if PropertyTypeElement.NativeValue = 1 then
    wbScriptPropertyObjectToStr(Container, PropertyName, PropertyType, PropertyValue);

  // 2-5 = String, Int32, Float, Bool
  if InRange(PropertyTypeElement.NativeValue, 2, 5) then
    PropertyValue := Container.ElementByName[PropertyType].Value;

  // 11-15 = Arrays of String, Int32, Float, Bool
  if InRange(PropertyTypeElement.NativeValue, 11, 15) then
    wbScriptPropertyArrayToStr(Container, PropertyType, PropertyValue);

  // 16 = Array of Variable (FO76, Not Implemented)
  if PropertyTypeElement.NativeValue = 16 then
    Exit;

  // 17 = Array of Struct
  if PropertyTypeElement.NativeValue = 17 then begin
    PropertyValue := '';
    PropertyType := PropertyType.Substring(9) + '[]';
  end;

  // set display string
  aValue := PropertyType + ' ' + PropertyName;

  if Length(PropertyValue) > 0 then
    aValue := aValue + ' = ' + PropertyValue;
end;

// TODO: used in too many places to replace with summary callbacks
procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  A: IwbElement;
  R, G, B: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if Container.ElementCount >= 3 then begin
    R := Container.Elements[0].Summary;
    G := Container.Elements[1].Summary;
    B := Container.Elements[2].Summary;
  end else
    Exit;

  if Container.ElementCount >= 4 then
    A := Container.Elements[3]
  else
    A := nil;

  if Assigned(A) then
    if (A.ConflictPriority <= cpIgnore) or (A.Def.DefType = dtByteArray) then
      A := nil;

  if Assigned(A) then
    aValue := 'RGBA(' + R + ', ' + G + ', ' + B + ', ' + A.Summary + ')'
  else
    aValue := 'RGB(' + R + ', ' + G + ', ' + B + ')';
end;

// TODO: used in too many places to replace with summary callbacks
procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var X := Container.Elements[0].Summary;
  var Y := Container.Elements[1].Summary;
  var Z := Container.Elements[2].Summary;

  aValue := 'Vec3(' + X + ', ' + Y + ', ' + Z + ')';
end;

{>>> For VMAD <<<}

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbGetScriptObjFormat(aElement);
end;

procedure wbScriptToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  CER: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, CER) then
    Exit;

  var eSCDA := CER.ElementBySignature[SCDA];
  var eSCTX := CER.ElementBySignature[SCTX];

  if not Assigned(eSCDA) then begin
    aValue := IfThen(Assigned(eSCTX), '<Source not compiled>', '<Empty>');
    Exit;
  end;

  if not Assigned(eSCTX) then begin
    aValue := '<Source missing>';
    Exit;
  end;

  with TStringList.Create do
  try
    Text := eSCTX.Value;

    for var i := Pred(Count) downto 0 do begin
      var s := Strings[i].Trim;

      if s.StartsWith(';') then
        s := '';

      if s = '' then
        Delete(i);
    end;

    if Count = 0 then
      aValue := '<Source missing>'
    else
      if Count = 1 then
        aValue := Strings[0].Trim
      else
        aValue := '<'+Count.ToString+' lines>';
  finally
    Free;
  end;
end;

end.


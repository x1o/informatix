program NameToInitials;

uses
	Strings,
	Matrix2D,
	crt;

var
	{ S: string = 'Hello, beautiful World!'; }
	NameList: array of string;
	FullName: TStringDynArray;
	i: integer;

begin
	{ PrintArray(Split(S)); }
	{ for Wrd in Split(S) do }
		{ writeln(Wrd); }
	{ writeln(CountChar(S)); }
	{ writeln(CountChar(S, ' ')); }

	clrscr;

	SetLength(NameList, 3);
	NameList[0] := 'Ivanov Ivan Ivanovich';
	NameList[1] := 'Sidoriv Egor Petrovich';
	NameList[2] := 'Kuznetcov Dmitriy Evgenjevich';
	PrintArray(NameList);

	for i:=Low(NameList) to High(NameList) do
	begin
		FullName := Split(NameList[i]);
		NameList[i] :=	FullName[0]+' '+
				FullName[1][1]+'.'+
				FullName[2][1]+'.';
	end;

	PrintArray(NameList);
end.

program WordLengthsHist;

uses
	{ Matrix2D, }
	Strings;

type
	Point = record
		Len: integer;
		Freq: real;
	end;
	Graph = array of Point;

var
	S: string = 'We will not get into mouse input in detail, because that syntax differs from machine to machine.';
	{ S: string = 'abc ab cd'; }
	S_words: TStringDynArray;
	Lx: array of integer;
	G: Graph;
	p: Point;
	i, n_matches: integer;

procedure AppendG(var G: Graph; p: Point);
var
	len: integer;
begin
	len := Length(G);
	SetLength(G, len+1);
	G[len] := p
end;

{ Ugly, but usually you get sorting routines 'for free' in decent
  languages (both in terms of complexity and implementation). }
procedure BubbleSort(var A: array of integer);
var
	i, j, t: integer;
begin
	for i:=Length(A) - 1 downto 1 do
	begin
		for j:=0 to i-1 do
		begin
			if A[j] > A[j+1] then
			begin
				t := A[j];
				A[j] := A[j+1];
				A[j+1] := t;
			end;
		end;
	end;
end;

	
begin
	writeln(S);
	S_words := Split(S);
	{ PrintArray(S_words); }
	{ writeln('---'); }
	SetLength(Lx, Length(S_words));
	for i:=0 to Length(S_words)-1 do
		Lx[i] := Length(S_words[i]);
	BubbleSort(Lx);
	{ PrintArray(Lx, ' '); }
	{ writeln('---'); }
	n_matches := 1;
	for i:=1 to Length(Lx)-1 do
	begin
		{ writeln('(', Lx[i-1], ', ', Lx[i], ')'); }
		if (Lx[i-1] = Lx[i]) then
			Inc(n_matches)
		else
		begin
			{ writeln('Mimatch: adding [', Lx[i-1], ', ', n_matches / Length(S_words), ']'); }
			p.Len := Lx[i-1];
			p.Freq := n_matches / Length(S_words);
			AppendG(G, p);
			n_matches := 1;
		end;
		if i = Length(Lx)-1 then
		begin
			{ writeln('EOL: adding [', Lx[i], ', ', n_matches / Length(S_words), ']'); }
			p.Len := Lx[i];
			p.Freq := n_matches / Length(S_words);
			AppendG(G, p);
		end;
	end;

	for i:=0 to Length(G)-1 do
		writeln(G[i].Len, ': ', G[i].Freq:2:2);
end.

program FixBraces;

type
	AAI = array of array of integer;
	AI  = array of integer;

var
	// S: string = '(1+2*(4-(55-4)-(42+4*(9+2-4/(2+5))-3)))';
	S: string = '((()(())))';  { should give: {{[][()]}} }
	i, j, lvl: integer;
	ixx: AAI;
	ix:  AI;
	paren: char;

procedure AppendA(var A: AAI; B: AI);
var
	l: integer;
begin
	l := Length(A);
	SetLength(A, l+1);
	A[l] := B;
end;

procedure AppendI(var A: AI; n: integer);
var
	l: integer;
begin
	l := Length(A);
	SetLength(A, l+1);
	A[l] := n;
end;

procedure PrintIxx(var A: AAI);
var
	i, j: integer;
begin
	for i:=0 to Length(ixx)-1 do
	begin
		write('[');
		for j:=0 to Length(ixx[i])-1 do
		begin
			write(ixx[i][j]);
			if not (j = Length(ixx[i])-1) then
				write(' ');
		end;
		write(']');
		if not (i = Length(ixx)-1) then
			write(', ')
		else
			writeln();
	end;
end;

begin
	SetLength(ixx, 1);
	SetLength(ix, 1);
	ix[0] := 1;
	ixx[0] := ix;
	lvl := 0;
	for i:=2 to Length(S) do
		case S[i] of
			'(':
				begin
					lvl := lvl + 1;
					if lvl > Length(Ixx)-1 then
					begin
						SetLength(ix, 1);
						ix[0] := i;
						AppendA(ixx, ix);
					end
					else
						AppendI(ixx[lvl], i);
				end;
			')':
				begin
					AppendI(ixx[lvl], i);
					lvl := lvl - 1;
				end;
		end;

	{ PrintIxx(ixx); }

	for lvl := 0 to Length(ixx)-1 do
		for i:=0 to Length(ixx[Length(ixx)-lvl-1]) do
		begin
			if i mod 2 = 0 then
				case lvl of
					0: paren := '(';
					1: paren := '[';
				else
					paren := '{';
			end
			else
				case lvl of
					0: paren := ')';
					1: paren := ']';
				else
					paren := '}';
			end;
			S[ixx[Length(ixx)-lvl-1][i]] := paren;
		end;
	
	writeln(S);
end.

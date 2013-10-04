program CountSubstringProg;

uses
	crt,
	Strings,
	Matrix2D;

var
	S: string = 'Man has the right to live by his own law: to work as he will, to play as he will, to rest as he will, to die when and how he will.';
	S2: string = 'AAAA BBB CC D';
	substr: string = 'will';

begin
	clrscr;
	{ PrintArray(Partition(S, Length(substr)), '|'); }
	{ PrintArray(Partition('hi', 2), '|'); }
	writeln(S);
	writeln('---');
	writeln('''', substr, ''' occured ', CountSubstring(S, substr), ' times');
end.

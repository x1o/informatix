program pruff;

const n = 7;

type v = ^t;
	t = record
		i: 1..n;
		r: v
	end;
	pru = array[0..n-2] of integer; {нулевой элемент – “корень”, равный n}

var
	k, i, j, a: integer; {n-1 – для основной программы  }
	sp: array[1..n] of v;
	x, y: v;  

procedure inpruff(var pr: pru); {строит код Прюфера по списку смежности}
var
	rab:boolean;  
begin             
	for j:=1 to n-2 do
	begin
		k:=1;
		repeat                                   
			rab:=false;                               
			if sp[k]=nil then
				k:=k+1                  
			else                                            
				if sp[k]^.r<>nil then
					k:=k+1    
				else rab:=true                  
		until rab; 
		a := sp[k]^.i;
		pr[j] := a;
		sp[k] := nil;
		x := sp[a];
		while (x^.i <> k)  do
		begin
			y:=x;
			x:=x^.r
		end;
        if sp[a]=x then
			sp[a]:=x^.r
		else
			y^r:=x^.r
        end;
end;


procedure outpruff; {преобразует код Прюфера в список смежности }
procedure bk(var a,b:integer);  {включить вершины a,b в список смежности}
begin
	new(x);
	new(y);
	x^.i:=a; x^.r:=sp[b]; sp[b]:=x;
	y^.i:=b; y^.r:=sp[a]; sp[a]:=y
end{bk};
begin
	for i:=1 to n do
		sp[i] := nil;
	pr[0] := n;
	a := pr[n-2];
	if a = n then
		i:=n-1
	else
		i:=n;
	bk(a,i);
	for j:=n-2 downto 1 do
		if sp[pr[j-1]]=nil
		then
			bk(pr[j-1],pr[j])
		else
		begin
			while sp[i] <> nil do
				i:=i-1;
			bk(i,pr[j])
		end
end{outpruff};

with text_io;
use text_io;

procedure procons2 is

	task Buffer is
		entry put;
		entry get;
	end Buffer;

	task body Buffer is
		stack : array (0..4) of integer;
		i : integer := 0;
		val : integer := 0;
	begin
		loop
			select
				when i < 5 => accept put do
					put_line("put[" & i'img & "]:" & val'img);
					stack(i) := val;
					i := i + 1;
					val := val + 1;
				end;
			or
				when i > 0 => accept get do
					i := i - 1;
					put_line("    get[" & i'img & "]:" & stack(i)'img);
				end;
			end select;
		end loop;
	end Buffer;

	task type Producer;
	task body Producer is
	begin
		loop
			Buffer.put;
			delay 0.1;
		end loop;
	end Producer;

	task type Consumer;
	task body Consumer is
	begin
		loop
			Buffer.get;
			delay 0.1;
		end loop;
	end Consumer;

	p1, p2, p3, p4, p5 : Producer;
	c1, c2, c3, c4, c5 : Consumer;


begin
	null;
end procons2;

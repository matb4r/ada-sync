with text_io;
use text_io;

procedure sm_n is

	protected semaphore is
		entry P(n : in integer);
		entry V(n : in integer);
		private 
			level : integer := 5;
			hold : boolean := false;
			entry priv_P(n : in integer);
	end semaphore;

	protected body semaphore
	is
		entry P(n : in integer) when true is
		begin
			if level >= n then
				level := level - n;
				put_line("-" & n'img);
				put_line("level:" & level'img);
			else
				hold := true;
				requeue priv_P;
			end if;
		end;

		entry priv_P(n : in integer) when not hold is
		begin
			requeue P;
		end;

		entry V(n : in integer) when true is
		begin
			level := level + n;
			hold := false;
			put_line("+" & n'img);
			put_line("level:" & level'img);
		end;
	end semaphore;

	task mytask2;
	task body mytask2 is
	begin
		loop
			semaphore.P(2);
			delay 0.5;
			semaphore.V(2);
			delay 0.5;
		end loop;
	end mytask2;

	task mytask3;
	task body mytask3 is
	begin
		loop
			semaphore.P(3);
			delay 0.5;
			semaphore.V(3);
			delay 0.5;
		end loop;
	end mytask3;

	task mytask4;
	task body mytask4 is
	begin
		loop
			semaphore.P(4);
			delay 0.5;
			semaphore.V(4);
			delay 0.5;
		end loop;
	end mytask4;

begin
	null;
end sm_n;

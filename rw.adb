with text_io;
use text_io;

procedure rw is

	protected Obiekt is
		entry acqEx;
		entry acqSh;
		entry relEx;
		entry relSh;
	private
		writers : integer := 0;
		readers : integer := 0;
	end;

	protected body Obiekt 
	is
		entry acqEx when writers=0 and readers=0 is
		begin
			writers := writers + 1;
			put_line("r" & readers'img & " w" & writers'img);
		end;

		entry acqSh when writers=0 is
		begin
			readers := readers + 1;
			put_line("r" & readers'img & " w" & writers'img);
		end;

		entry relEx when true is
		begin
			writers := writers - 1;
			put_line("r" & readers'img & " w" & writers'img);
		end;

		entry relSh when true is
		begin
			readers := readers - 1;
			put_line("r" & readers'img & " w" & writers'img);
		end;
			
	end Obiekt;
		
	task type czytelnik;
	task body czytelnik is
	begin
		loop
			Obiekt.acqSh;
			delay 0.1;
			Obiekt.relSh;
			delay 0.3;
		end loop;
	end czytelnik;

	task type pisarz;
	task body pisarz is
	begin
		loop
			Obiekt.acqEx;
			delay 0.1;
			Obiekt.relEx;
			delay 0.3;
		end loop;
	end pisarz;

	p1, p2, p3 : pisarz;
	c1, c2, c3 : czytelnik;

begin
	null;
end rw;

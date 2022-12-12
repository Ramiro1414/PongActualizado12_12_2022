program PongActualizado;

uses Crt, ptcGraph, ptcCrt, UNIT_MODOS_DE_JUEGO, MMSystem;

var
Driver, Modo: integer;
tecla: char;
ProgramRunning: boolean = true;

Procedure IniciarModoGrafico;
begin
{
    Inicia el modo grafico. Pantalla 640px * 480px.
}
Driver := VGA;
Modo := VgaHi;
InitGraph(Driver, Modo, 'c:\tp\bgi');
end;

Procedure DrawMenu;
begin
{
    Dibujo el menu con las opciones para seleccionar.
}
    setcolor(white);
    SetTextStyle(0,HorizDir,2);
    OutTextXY(250, 20, 'Pong Game');
    Line(250, 40, 390, 40);
    Line(250, 45, 390, 45);
    OutTextXY(250, 100, 'Jugar [J]');
    OutTextXY(250, 130, 'Ayuda [A]');
    OutTextXY(235, 160, 'Salir [Esc]');
end;

Procedure DrawAyuda;
{
    Dibujo la ayuda para el jugador.
}
begin
setcolor(white);
OutTextXY(15, 20, 'Pong es un videojuego basado en tenis '); 
OutTextXY(15, 40, 'de mesa o ping pong, en el cual los');
OutTextXY(15, 60, 'jugadores deben moverse verticalmente');
OutTextXY(15, 80, '(usando las teclas W & S y UpArrow &');
OutTextXY(15, 100, 'DownArrow) y golpear una pelota');
OutTextXY(15, 120, 'logrando que el otro jugador no');
OutTextXY(15, 140, 'devuelva el tiro.');
OutTextXY(15, 180, 'Alumnos:');
OutTextXY(15, 200, 'Eric Anderson y Ramiro Parra.');
OutTextXY(15, 220, 'Docentes:');
OutTextXY(15, 240, 'Leonardo Moreno y Juan Manuel Cortez');
SetColor(cyan);
OutTextXY(250, 280, 'UNPSJB');
SetColor(white);
OutTextXY(70, 320, 'Para volver al menu presione');
OutTextXY(200, 340, '<BACKSPACE>')
end;

procedure DrawSeleccionarModoJuego;
begin
setcolor(white);
OutTextXY(15, 20, 'Jugador contra maquina:');
OutTextXY(60, 60, 'Facil [1]');
setfillstyle(1,white);
fillellipse(50, 67, 2, 2);
OutTextXY(60, 100, 'Intermedio [2]');
fillellipse(50, 107, 2, 2);
OutTextXY(60, 140, 'Dificil [3]');
fillellipse(50, 147, 2, 2);
OutTextXY(15, 180, 'Jugador contra jugador (local) [4]');
end;

Procedure RecorrerMenu;
var
UserInMenu, UserInAyuda, UserInJugar: boolean;
begin {procedure}
UserInMenu:= True;
UserInAyuda:= False;
UserInJugar:= False;
{
    Como funciona el menu:
        Se utilizan tres variables booleanas, cuyos valores van alternando a medida que el usuario ingresa distintas opciones.
        El programa comienza con UserInMenu = True, y dependiendo la letra que presione, cambia los valores de las otras variables (por ejemplo, si se presiona
        'a' o 'A', UserInMenu pasa a ser False, y UserInAyuda pasa a ser True, por lo que el programa entra en el "while" de Ayuda, y sale cuando presiona 
        <BACKSPACE>, y luego UserInMenu = True y UserInAyuda = False) accediendo a otros "while". Cada "while" es una seccion del menu que maneja 
        los output de la pantalla, asi como los variables booleanas y las units que utilizan.
}
while ProgramRunning do // ProgramRunning es una booleana que indica el estado del programa.
begin
    while UserInMenu do // Cuando el usuario esté en el menu.
        begin
            PlaySound('StartupMenu.wav',0,1);
            DrawMenu;
            tecla:= readkey;
                if ((tecla = 'a') or (tecla = 'A')) then
                    begin 
                        UserInMenu:= False;
                        ClearDevice;
                        UserInAyuda:= True;
                    end;
                if ((tecla = 'j') or (tecla = 'J')) then
                    begin
                        UserInMenu:= False;
                        ClearDevice;
                        UserInJugar:= True;
                    end;
                if tecla = #27 then
                    begin
                        UserInMenu:= False;
                        ProgramRunning:= False;
                    end;
        end;

    while UserInAyuda do
        begin
            PlaySound('MenuSelect.wav',0,1);
            DrawAyuda;
            tecla:= readkey;
                if (tecla = #8) then
                    begin
                        UserInAyuda:= False;
                        ClearDevice;
                        UserInMenu:= True;
                    end;
        end;

    while UserInJugar do
        begin
            PlaySound('MenuSelect.wav',0,1);
            DrawSeleccionarModoJuego; // Dibuja Seleccion modo de juego
            tecla:= readkey;
                if (tecla = #8) then
                    begin
                        UserInJugar:= False;
                        ClearDevice;
                        UserInMenu:= True;
                    end;
                if (tecla = #49) then {si usuario ingresa 1, juega vs IA Facil}
                    begin
                        PlaySound('GamemodeSelect.wav',0,1);
                        ClearDevice;
                        PONG1VSIA_FACIL;
                    end; {1}
                if (tecla = #50) then {si usuario ingresa 2, juega vs IA Intermedio}
                    begin
                        PlaySound('GamemodeSelect.wav',0,1);
                        ClearDevice;
                        PONG1VSIA_INTERMEDIO;
                    end; {2}
                if (tecla = #51) then {si usuario ingresa 3, juega vs IA Dificil}
                    begin
                        PlaySound('GamemodeSelect.wav',0,1);
                        ClearDevice;
                        PONG1VSIA_DIFICIL;
                    end; {3}
                if (tecla = #52) then {si usuario ingresa 4, juega Jugador vs Jugador}
                    begin
                        PlaySound('GamemodeSelect.wav',0,1);
                        ClearDevice;
                        PONG1V1;
                        ClearDevice;
                    end; {4}
        end; {while}
end; {while main}

end;

begin {program}
IniciarModoGrafico;
RecorrerMenu;
end. {program}
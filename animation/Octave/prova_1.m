% Numero di sfere
clear;
num_spheres = 3;
dim = 3;
sz = 0.05;

% Numero di frame dell'animazione
pos = csvread('logfile.csv');
num_frames = size(pos, 1);
pos = reshape(pos, num_frames, 3, 3);

% Inizializza la figura 3D
figure('units','normalized','outerposition',[0 0 1 1]);

axis equal;
axis([-1 1 -1 1 -1 1]);
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
hold on;
pause(3);
% Crea un ciclo per l'animazione
for frame = 1:num_frames
    % Estrai le posizioni per il frame corrente
    frame_positions = squeeze(pos(frame,:,:));

    % Visualizza le sfere
    for i = 1:num_spheres
        % Estrai la posizione della sfera corrente
        x = frame_positions(1, i);
        y = frame_positions(2, i);
        z = frame_positions(3, i);

        % Disegna la sfera corrente
        [X,Y,Z] = sphere(20);
        surf(X*sz+x, Y*sz+y, Z*sz+z, 'FaceColor', 'red', 'EdgeColor', 'none');
    end

    % Opzionale: imposta il ritmo dell'animazione
    pause(.01); % Pausa di 0.1 secondi

    % Aggiorna la visualizzazione della figura
    drawnow;

    % Pulisci la figura per il prossimo frame
    cla;
    axis([-dim dim -dim dim -dim dim]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    hold on;
end


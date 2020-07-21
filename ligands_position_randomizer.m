clear,clc
protein = importdata('5oqv.xyz');
xcoords_pro = protein.data(:,1);
ycoords_pro = protein.data(:,2);
zcoords_pro = protein.data(:,3);

l1_pro = find(xcoords_pro==max(xcoords_pro));

location1_max(1) = xcoords_pro(l1_pro,:);
location1_max(2) = ycoords_pro(l1_pro,:);
location1_max(3) = zcoords_pro(l1_pro,:);


l2_pro = find(ycoords_pro==max(ycoords_pro));

location2_max(1) = xcoords_pro(l2_pro,:);
location2_max(2) = ycoords_pro(l2_pro,:);
location2_max(3) = zcoords_pro(l2_pro,:);



l3_pro = find(zcoords_pro==max(zcoords_pro));

location3_max(1) = xcoords_pro(l3_pro,:);
location3_max(2) = ycoords_pro(l3_pro,:);
location3_max(3) = zcoords_pro(l3_pro,:);

l4_pro = find(xcoords_pro==min(xcoords_pro));

location1_min(1) = xcoords_pro(l4_pro,:);
location1_min(2) = ycoords_pro(l4_pro,:);
location1_min(3) = zcoords_pro(l4_pro,:);


l5_pro = find(ycoords_pro==min(ycoords_pro));

location2_min(1) = xcoords_pro(l5_pro,:);
location2_min(2) = ycoords_pro(l5_pro,:);
location2_min(3) = zcoords_pro(l5_pro,:);

l6_pro = find(zcoords_pro==min(zcoords_pro));

location3_min(1) = xcoords_pro(l6_pro,:);
location3_min(2) = ycoords_pro(l6_pro,:);
location3_min(3) = zcoords_pro(l6_pro,:);


ligand = importdata('beta-asp.xyz');
xcoords_lig = ligand.data(:,1);
ycoords_lig = ligand.data(:,2);
zcoords_lig = ligand.data(:,3);


l1_lig_max = max(xcoords_lig);
l1_lig_min = min(xcoords_lig);

l2_lig_max = max(ycoords_lig);
l2_lig_min = min(ycoords_lig);

l3_lig_max = max(zcoords_lig);
l3_lig_min = min(zcoords_lig);

lig_dist_x = abs(l1_lig_max - l1_lig_min);
lig_dist_y = abs(l2_lig_max - l2_lig_min);
lig_dist_z = abs(l3_lig_max - l3_lig_min);

max_of_all = max([lig_dist_x,lig_dist_y,lig_dist_z]);



box_padding = 30; % Angstroms

padding_max_y = location2_max(2) + box_padding;
padding_min_y = location2_min(2) - box_padding;

padding_max_x = location1_max(1) + box_padding;
padding_min_x = location1_min(1) - box_padding;

padding_max_z = location3_max(3) + box_padding;
padding_min_z = location3_min(3) - box_padding;

No_ligands = 55;
k  = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% CASE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% For First point %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1;

while true
    
    
    % while true
    random_x = padding_min_x + ( padding_max_x - padding_min_x).*rand(1);
    
    %        if random_x > location1_max(1) || random_x < location1_min(1)
    %             random_x;
    %             break
    %         end
    %end
    
    %  while true
    random_y = padding_min_y + ( padding_max_y - padding_min_y).*rand(1);
    %         if random_y > location2_max(2) || random_y < location2_min(2)
    %             random_y;
    %             break
    %         end
    % end
    
    while true
        random_z = padding_min_z + ( padding_max_z - padding_min_z).*rand(1);
        if random_z > location3_max(3) || random_z < location3_min(3)
            random_z;
            break
        end
    end
    
    pos_x(i,1) = random_x;
    pos_y(i,1) = random_y;
    pos_z(i,1) = random_z;
    
    if i > 1
        
        %%%% checking x distance
        
        distx_bw_ligs = abs(pos_x(i) - pos_x(1:i-1));
        if distx_bw_ligs < abs(lig_dist_x)
            m = m - 1;
            
        else
            m = m + 1;
        end
        
        
        disty_bw_ligs = abs(pos_y(i) - pos_y(1:i-1));
        
        if disty_bw_ligs < abs(lig_dist_y)
            n = n - 1;
            
        else
            n = n + 1;
        end
        
        
        distz_bw_ligs = abs(pos_z(i) - pos_z(1:i-1));
        
        if distz_bw_ligs < abs(lig_dist_z)
            o = o - 1;
            
        else
            o = o + 1;
        end
        
       % ligand_pos(i,:) = [pos_x(i,1) pos_y(i,1) pos_z(i,1)]
        
        if m == n && n == o && m == o
            
            actual_dist = sqrt((pos_x(i,1)-pos_x(1:i-1,1)).^2 + (pos_y(i,1)-pos_y(1:i-1,1)).^2 + (pos_z(i,1)-pos_z(1:i-1,1)).^2);
            
            if actual_dist > max_of_all
                
                i = i + 1;
            end
        else
            i = i - 1;
        end
        
    end
    
    if i > No_ligands
        break
    end
    
    if k > 5 * No_ligands
        disp('Decrease the Number of ligands or increase the padding')
        break
    end
    
    if i == 1
        i = i + 1
        m = 2;
        n = 2;
        o = 2;
    end
    %  i = i + 1;
    k = k +1
end

ligand_pos = [pos_x pos_y pos_z];

plot3(xcoords_pro,ycoords_pro,zcoords_pro,'.')
hold on
plot3(ligand_pos(:,1),ligand_pos(:,2),ligand_pos(:,3),'.','MarkerSize',50)
%plot3(pos_x,pos_y,pos_z,'.','MarkerSize',50)

xlabel('x');
ylabel('y')
zlabel('z')




%
%
% figure
%
% plot3(xcoords_pro,ycoords_pro,zcoords_pro,'.');
% hold on
% plot3(location1_max(1),location1_max(2),location1_max(3),'.','MarkerSize',50);
% hold on
% plot3(location2_max(1),location2_max(2),location2_max(3),'.','MarkerSize',50);
% hold on
% plot3(location3_max(1),location3_max(2),location3_max(3),'.','MarkerSize',50);
% hold on
% plot3(location1_min(1),location1_min(2),location1_min(3),'.','MarkerSize',50);
% hold on
% plot3(location2_min(1),location2_min(2),location2_min(3),'.','MarkerSize',50);
% hold on
% plot3(location3_min(1),location3_min(2),location3_min(3),'.','MarkerSize',50);
%
%
%
%
%
% bound_pro = boundary(protein.data);
% hold on
%
%
% trisurf(bound_pro,xcoords_pro,ycoords_pro,zcoords_pro,'Facecolor','red','FaceAlpha',0.1) % Creating the boundaries
%
% ligand = importdata('beta-asp.xyz');
% xcoords_lig = ligand.data(:,1);
% ycoords_lig = ligand.data(:,2);
% zcoords_lig = ligand.data(:,3);
%
% figure
%
% scatter3(xcoords_lig,ycoords_lig,zcoords_lig,'.');
%
% bound_lig = boundary(ligand.data);
%
% hold on
%
% trisurf(bound_lig,xcoords_lig,ycoords_lig,zcoords_lig,'Facecolor','red','FaceAlpha',0.1) % Creating the boundaries
%
% xlig_center = mean(xcoords_lig)
% ylig_center = mean(ycoords_lig)
% zlig_center = mean(zcoords_lig)



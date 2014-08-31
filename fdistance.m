function d= fdistance(F1,F2)
    d = (F1.ux - F2.ux)^2 + (F1.uy - F2.uy)^2 + (F1.vx - F2.vx)^2 + (F1.vy - F2.vy)^2;
    d = d/(80^2);
 end
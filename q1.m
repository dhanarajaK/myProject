clear all;
m = 11; n = 7;
one = deviation(m, n); 
ans1 = round(mean(one(:)),10)

ans2 = round(std(one(:)), 10)

m = 23; n = 31;
two = deviation(m, n); 
ans3 = round(mean(two(:)),10)

ans4 = round(std(two(:)), 10)

ans5 = round(length(one(one > 0.6))/length(one(one > 0.2)), 10)

ans6 = round(length(two(two > 0.6))/length(two(two > 0.2)), 10)
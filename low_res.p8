pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
plr1 = nil
dbg={}
enms={}
function _init()
	poke(0x5f2c,3)
	inp={}
	lsr={x=0,y=0}
	for i=0,5 do add(inp,0)end
	plr1={x=28,y=28,dir=1,spd=0.5,inp=inp,num=0,lsr=lsr}
	e=nenm(enms,16,16)
	--e.vx=0.125
end

function _draw()
	cls(1)
	spr(16,0,0)
	spr(17,8,0)
	for i,t in pairs(dbg) do print(t,0,i*8) end
	dbg={}
	for e in all(enms) do spr(e.s,e.x,e.y,e.w,e.w) end
	plrdraw(plr1)
end

function _update60()
	for e in all(enms) do e.x+=e.vx e.y+=e.vy end
	input(plr1)
	plrmove(plr1)
	ray(plr1,enms)
end

function ray(plr,enms)
	if plr.inp[5]==0 then plr.lsr.x=plr.x plr.lsr.y=plr.y return end
	dir=plr.dir/4
	x=cos(dir)*100+plr.x
	y=sin(dir)*100+plr.y
	plr.lsr.x=x=clp(x,-8,63)
	plr.lsr.y=y=clp(y,-8,63)
	dis = 100
	col = nil
	function ma(a,b) return (a<0 and b<0) or (a>=0 and b>=0) end
	for e in all(enms) do
		--t = hitc(e.x,e.y,4,plr.x,plr.y,plr.lsr.x,plr.lsr.y)
		--add(dbg,t)
	end
end

function nenm(enms,x,y)
	e={x=x,y=y,vx=0,vy=0,s=11,w=1}
	add(enms,e) return e
end

function clp(v,mn,mx) if v<mn then return mn end if v>mx then return mx end return v end

function plrmove(plr)
	dir=-1
	spd=plr.spd
	if plr.inp[5]>0 then spd *= 0.6 end
	if plr.inp[0]>0 then plr.x-=spd dir=2 end
	if plr.inp[1]>0 then plr.x+=spd dir=0 end
	if plr.inp[2]>0 then plr.y-=spd dir=1 end
	if plr.inp[3]>0 then plr.y+=spd dir=3 end
	if plr.inp[4]==0 and dir!=-1 then plr.dir = dir end
	mn=-4 mx=60
	if plr.x<mn then plr.x=mn end
	if plr.x>mx then plr.x=mx end
	if plr.y<mn then plr.y=mn end
	if plr.y>mx then plr.y=mx end
end

function input(plr)
	for i=0,5 do
		if btn(i,plr.num) then
			plr.inp[i]+=1
		else
			plr.inp[i]=0
		end
	end
end

function plrdraw(plr)
	line(plr.x+4,plr.y+4,plr.lsr.x+4,plr.lsr.y+4)
	sp=7+2*plr.num+1-plr.dir%2
	spr(sp,plr.x,plr.y,1,1,plr.dir==2,plr.dir==3)
end

__gfx__
000000000000000000070000007500000750000075000000500000000000000000000000000000000000000000eeee000ee00000000000000000000000000000
000000005887000008850000088000000880000008800000788000000008800088000000000cc000cc0000000eeeeee0e00e0000000000000000000000000000
00700700788500005880000008800000088000000880000008870000008118008588880000c11c00c5cccc00eee00eeee00e0000000000000000000000000000
0007700000000000700000005700000005700000005700000005000000811800a551118000c11c00a55111c0ee0000ee0ee00000000000000000000000000000
0007700000000000000000000000000000000000000000000000000000811800a551118000c11c00a55111c0ee0000ee00000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000008558008588880000c55c00c5cccc00eee00eee00000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000008555580880000000c5555c0cc0000000eeeeee000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000088aa880000000000ccaacc00000000000eeee0000000000000000000000000000000000
80080808088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
80080080080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88080080880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

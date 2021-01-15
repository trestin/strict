# strict
declare global variable before use

云风解决userdata无法及时回收：
我见过不少人曾在邮件列表中抱怨，自己实现的 userdata 可能能被 Lua 感知到的内存并没有多少（只有一个指针），
但实际占了很大的内存（背后的 C/C++ 对象），lua 虚拟机无法正确的驱动 GC 工作。如果大量分配这种 userdata ，
程序使用的内存暴涨，无法及时回收。其实，正确的方法很简单，在分配新的 userdata 时，
利用 lua_gc 传入 LUA_GCSTEP 让它步进相应真实占据的内存数量就可以了，而没有必要让虚拟机记住这个 userdata 真的使用了多少内存。
https://blog.codingnow.com/2018/10/lua_gc.html

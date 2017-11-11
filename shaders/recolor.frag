uniform color Object_color;
uniform float Range;

if (texscreen(SCREEN_UV).r = Object_color.r - Range && texscreen(SCREEN_UV).r = Object_color.r + Range)
{
    if (texscreen(SCREEN_UV).g = Object_color.g - Range && texscreen(SCREEN_UV).g = Object_color.g + Range)
    {
        if (texscreen(SCREEN_UV).b = Object_color.b - Range && texscreen(SCREEN_UV).b = Object_color.b + Range)
        {
            COLOR.a = tex(TEXTURE, UV).a;
        }
        else
        {
            COLOR.w = 0;
        }
    }
    else
    {
        COLOR.w = 0;
    }
}
else
{
    COLOR.w = 0;
}
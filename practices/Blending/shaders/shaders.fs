#version 400 core
out vec4 FragColor;

in vec2 TexCoords;

// texture sampler
uniform sampler2D texture1;

void main()
{
    FragColor = texture(texture1, TexCoords);
}
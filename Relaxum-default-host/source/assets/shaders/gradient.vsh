uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

void main () {
    gl_Position = position * transform;
    colorVarying = color;
}

varying LOWP vec4 colorVarying;
uniform sampler2D sampler;
 
void main() {
    gl_FragColor = colorVarying;
}

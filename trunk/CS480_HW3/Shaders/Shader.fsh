//
//  Shader.fsh
//  CS480_HW3
//
//  Created by Greg Lieberman on 4/22/10.
//  Copyright Greg Lieberman 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}

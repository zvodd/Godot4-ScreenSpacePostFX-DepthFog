Screen Space Depth Fog

Godot 4 volumetric fog replaced Godot 3 depth fog. This camera setup impliments the setup required to create a Post FX with depth sampling in Godot 4 ala this guide: https://docs.godotengine.org/en/4.0/tutorials/shaders/advanced_postprocessing.html

It contains a scene with a 3D Camera Setup for with a Quad mesh stretched in front and uses a fragment shader to create a Distance/Depth based fog effect. The Fog also has a 2 color noise effect. The shader has input paramters to set the distance, colors and timescale of the noise.
The second effect is a 2D Canvas shader that fades in from black, controlled by a script tweeen.
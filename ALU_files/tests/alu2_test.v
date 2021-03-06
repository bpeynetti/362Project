module testbench;
    
    reg [0:31] A, B;
    reg [0:3] ctrl;
    wire [0:31] ALUout;
    wire zero,of;
    
    alu ALU(A, B, ctrl, ALUout, zero,of);
    
    initial begin
        $monitor("%h,%h,%b,%h,%h,%b",A,B,ctrl,ALUout,zero,of);

		#0 A=32'h8ccd1c83; B=32'hc6959c46; ctrl=32'b1100;
		#1 A=32'h1164c7e1; B=32'hba4dadd1; ctrl=32'b1100;
		#1 A=32'heda2b713; B=32'h0427ac91; ctrl=32'b0000;
		#1 A=32'hc84aea44; B=32'heda2aaec; ctrl=32'b1101;
		#1 A=32'h2ec8476b; B=32'h399c0ca1; ctrl=32'b0100;
		#1 A=32'h40464cac; B=32'h932a0f08; ctrl=32'b1101;
		#1 A=32'h115d736e; B=32'h9d0d3e60; ctrl=32'b1001;
		#1 A=32'h15669284; B=32'hfa4dab5c; ctrl=32'b1001;
		#1 A=32'haba5bc42; B=32'h7cc425b4; ctrl=32'b1100;
		#1 A=32'h6ff89595; B=32'hea67ef4e; ctrl=32'b1110;
		#1 A=32'h99f68f1d; B=32'hc874b90f; ctrl=32'b1100;
		#1 A=32'h6d0887a5; B=32'hfb69a4d4; ctrl=32'b1100;
		#1 A=32'hf5d192e7; B=32'h91cdd018; ctrl=32'b1110;
		#1 A=32'h90cb6047; B=32'h5a3aee3f; ctrl=32'b0111;
		#1 A=32'hc9dfbc1e; B=32'h97cb815c; ctrl=32'b0101;
		#1 A=32'h4afee73d; B=32'he9dae2d2; ctrl=32'b1011;
		#1 A=32'hdc50f154; B=32'hc19e71ff; ctrl=32'b0100;
		#1 A=32'h660a7501; B=32'h2bd16be4; ctrl=32'b0010;
		#1 A=32'h048691d1; B=32'h86bbc33b; ctrl=32'b0000;
		#1 A=32'h90853cdf; B=32'h1b47f759; ctrl=32'b0111;
		#1 A=32'hb7b1b9de; B=32'h1e718403; ctrl=32'b1101;
		#1 A=32'h39e099ce; B=32'hf7a0c3dd; ctrl=32'b1100;
		#1 A=32'hfb298c80; B=32'h7306e6d9; ctrl=32'b1110;
		#1 A=32'hd6c76002; B=32'h269d29fc; ctrl=32'b1101;
		#1 A=32'hf7d66105; B=32'ha6580715; ctrl=32'b1101;
		#1 A=32'hea63c94a; B=32'h2b116057; ctrl=32'b1101;
		#1 A=32'h0dc584c9; B=32'h8c7b5db0; ctrl=32'b0011;
		#1 A=32'h4d20ed27; B=32'h51f0e1f1; ctrl=32'b1011;
		#1 A=32'ha05c9706; B=32'h88a0b539; ctrl=32'b0011;
		#1 A=32'h4d1b9773; B=32'hf2722fb2; ctrl=32'b0101;
		#1 A=32'h95eee5b1; B=32'h711a83fe; ctrl=32'b1100;
		#1 A=32'hc44a643a; B=32'h2a6a581f; ctrl=32'b1011;
		#1 A=32'hb8070a17; B=32'hdb2c8319; ctrl=32'b0111;
		#1 A=32'h15c7a920; B=32'h6815373e; ctrl=32'b0111;
		#1 A=32'he8350606; B=32'h86ef2685; ctrl=32'b1110;
		#1 A=32'h9414a848; B=32'h7dbf37b2; ctrl=32'b1100;
		#1 A=32'h1d1cf773; B=32'h6a2e8cbc; ctrl=32'b1011;
		#1 A=32'he566db6b; B=32'h74f70705; ctrl=32'b1011;
		#1 A=32'ha978a160; B=32'h74bd1382; ctrl=32'b1110;
		#1 A=32'hecc8ff14; B=32'h17552988; ctrl=32'b0010;
		#1 A=32'h4e97c9bd; B=32'h2de0c538; ctrl=32'b0010;
		#1 A=32'h83c4bd30; B=32'hc64bcee9; ctrl=32'b1010;
		#1 A=32'h39bf2e2c; B=32'he2235a47; ctrl=32'b1011;
		#1 A=32'h4bc994e1; B=32'h6f3954b7; ctrl=32'b0000;
		#1 A=32'h7051171c; B=32'h3a2de4ae; ctrl=32'b0001;
		#1 A=32'hc5a7cd00; B=32'he4cbc28d; ctrl=32'b0100;
		#1 A=32'hecf478df; B=32'h10152551; ctrl=32'b1010;
		#1 A=32'hf9f6eb65; B=32'hee3cfc4d; ctrl=32'b0101;
		#1 A=32'h2d835a58; B=32'hf7f236fa; ctrl=32'b1101;
		#1 A=32'he2ce3a23; B=32'hf169878e; ctrl=32'b1101;
		#1 A=32'h9ccd3c3e; B=32'h88006437; ctrl=32'b0001;
		#1 A=32'h15c44ccc; B=32'h841106d1; ctrl=32'b0110;
		#1 A=32'h318c9975; B=32'h2a70d681; ctrl=32'b1000;
		#1 A=32'h11d36477; B=32'h61733881; ctrl=32'b1011;
		#1 A=32'he2a4e2e8; B=32'h8e8b38d3; ctrl=32'b0111;
		#1 A=32'h25c73282; B=32'h2a593691; ctrl=32'b0110;
		#1 A=32'hf9995383; B=32'h9ee851c8; ctrl=32'b1100;
		#1 A=32'h2c754f86; B=32'hbb3774a4; ctrl=32'b0001;
		#1 A=32'h5fdf8daf; B=32'hfc550f33; ctrl=32'b0000;
		#1 A=32'h84c88cf8; B=32'hf1fd4fb2; ctrl=32'b0000;
		#1 A=32'h822123bb; B=32'h17f7acad; ctrl=32'b0100;
		#1 A=32'h2e275d6e; B=32'hee52d418; ctrl=32'b1110;
		#1 A=32'h436342f0; B=32'hc3cda37d; ctrl=32'b0010;
		#1 A=32'h7cd76c5e; B=32'h9fea22d1; ctrl=32'b0100;
		#1 A=32'h3d283f74; B=32'h1b4b9ac2; ctrl=32'b1011;
		#1 A=32'h1093caa4; B=32'h0e47af28; ctrl=32'b0011;
		#1 A=32'h61f09b91; B=32'h0999fa6a; ctrl=32'b0000;
		#1 A=32'hc136bb25; B=32'h23aae3e1; ctrl=32'b1101;
		#1 A=32'hf7eb19ed; B=32'haf657f39; ctrl=32'b1101;
		#1 A=32'ha90a9a49; B=32'h73e41e8c; ctrl=32'b0101;
		#1 A=32'h3dcb9b97; B=32'h740538cb; ctrl=32'b1011;
		#1 A=32'h94cf96c9; B=32'h8b1edd6f; ctrl=32'b1011;
		#1 A=32'h2d92ee93; B=32'h284ceb5f; ctrl=32'b1110;
		#1 A=32'h0ad527f9; B=32'h20258356; ctrl=32'b1110;
		#1 A=32'h39f431ba; B=32'h850346f5; ctrl=32'b0101;
		#1 A=32'h3fdc120f; B=32'h984dd0a8; ctrl=32'b1101;
		#1 A=32'haaf05af6; B=32'h40744566; ctrl=32'b1100;
		#1 A=32'h632ab451; B=32'h7ef3e7a5; ctrl=32'b0010;
		#1 A=32'h33598ae8; B=32'h3737e911; ctrl=32'b1010;
		#1 A=32'he326f137; B=32'h78b94563; ctrl=32'b0101;
		#1 A=32'h8e902fe2; B=32'h2d96e06d; ctrl=32'b1101;
		#1 A=32'h9f6df7b1; B=32'h234aadaa; ctrl=32'b0110;
		#1 A=32'h96069bf4; B=32'h7bbdcf94; ctrl=32'b0000;
		#1 A=32'h845eb8f0; B=32'h6f1680d4; ctrl=32'b1101;
		#1 A=32'hf8428354; B=32'hb1f297aa; ctrl=32'b1001;
		#1 A=32'hd6ade1bd; B=32'h4cfad0e3; ctrl=32'b0001;
		#1 A=32'h0c754538; B=32'hf4ba6606; ctrl=32'b0000;
		#1 A=32'h82dc519b; B=32'h6f0fdd7a; ctrl=32'b0001;
		#1 A=32'hef870fb5; B=32'h1f62c2f6; ctrl=32'b1000;
		#1 A=32'h8c9395e4; B=32'hb9eafd54; ctrl=32'b1010;
		#1 A=32'h4647fd0a; B=32'hfef614fd; ctrl=32'b0000;
		#1 A=32'h9af3a0f1; B=32'h7f21f6de; ctrl=32'b0100;
		#1 A=32'h39bf0a54; B=32'h1ba68e5f; ctrl=32'b1110;
		#1 A=32'h4ec64e70; B=32'h5f32e66c; ctrl=32'b0110;
		#1 A=32'h2a9de782; B=32'hbea877a3; ctrl=32'b1011;
		#1 A=32'h07ce08fd; B=32'heff77335; ctrl=32'b0000;
		#1 A=32'h0361e6b3; B=32'hd250e334; ctrl=32'b1101;
		#1 A=32'ha59ba167; B=32'h3797f391; ctrl=32'b0110;
		#1 A=32'h0c9f4c08; B=32'h3af10f3d; ctrl=32'b0011;
		#1 A=32'hd8b0dbc3; B=32'h769c3147; ctrl=32'b0101;
		#1 A=32'hfac56fa2; B=32'h371a2f50; ctrl=32'b0001;
		#1 A=32'h51e1b209; B=32'h115a3b54; ctrl=32'b0100;
		#1 A=32'hf176ea17; B=32'he84093aa; ctrl=32'b1101;
		#1 A=32'h1b3f4744; B=32'h402f7427; ctrl=32'b1011;
		#1 A=32'hb4105163; B=32'h5641724a; ctrl=32'b1001;
		#1 A=32'hb8e9d14f; B=32'h6fa19d2d; ctrl=32'b1001;
		#1 A=32'h7a8e68fa; B=32'h04346013; ctrl=32'b1100;
		#1 A=32'h00b01c99; B=32'hd42cc5b3; ctrl=32'b1001;
		#1 A=32'hbfce0350; B=32'ha8229f30; ctrl=32'b0110;
		#1 A=32'ha41f213e; B=32'h90bbbacc; ctrl=32'b0101;
		#1 A=32'hef8b71ae; B=32'ha1868862; ctrl=32'b1001;
		#1 A=32'h1298fac9; B=32'h7f65fbe4; ctrl=32'b0111;
		#1 A=32'h117d1eb9; B=32'h10d6bb94; ctrl=32'b0111;
		#1 A=32'ha74089c9; B=32'h30492f8c; ctrl=32'b1101;
		#1 A=32'h471f1802; B=32'h09140936; ctrl=32'b1110;
		#1 A=32'h04c1dbb5; B=32'hc59c4b75; ctrl=32'b0011;
		#1 A=32'h0243fd77; B=32'h0a672753; ctrl=32'b0010;
		#1 A=32'hc4583464; B=32'h3f70635e; ctrl=32'b1001;
		#1 A=32'hd3b94035; B=32'h1548470b; ctrl=32'b0100;
		#1 A=32'hf37226ef; B=32'h5033017d; ctrl=32'b0111;
		#1 A=32'h016495ff; B=32'h50528609; ctrl=32'b0110;
		#1 A=32'h304ccdd5; B=32'h5c0969e9; ctrl=32'b0100;
		#1 A=32'haa1b8e5e; B=32'h1c51e402; ctrl=32'b0100;
		#1 A=32'hd9918d8f; B=32'hcc7f5ce7; ctrl=32'b0110;
		#1 A=32'h213bf163; B=32'hf9b1d869; ctrl=32'b1001;
		#1 A=32'hdb4c121d; B=32'h0d650d18; ctrl=32'b0111;
		#1 A=32'h86cd476f; B=32'h4618db70; ctrl=32'b1001;
		#1 A=32'hadc52d54; B=32'hb6608bfa; ctrl=32'b0001;
		#1 A=32'h0c5cc19b; B=32'h36f444d8; ctrl=32'b0000;
		#1 A=32'hc4928bc3; B=32'hf309f9a0; ctrl=32'b0100;
		#1 A=32'he1a6babf; B=32'h3563c672; ctrl=32'b0010;
		#1 A=32'h9d6a7bdd; B=32'h249b871a; ctrl=32'b1110;
		#1 A=32'h7f6d9313; B=32'h86ab895c; ctrl=32'b0110;
		#1 A=32'h96f7d113; B=32'h3e18b132; ctrl=32'b0011;
		#1 A=32'h8f08370b; B=32'hb1cc8976; ctrl=32'b0110;
		#1 A=32'h02a5b459; B=32'hf3358d31; ctrl=32'b1001;
		#1 A=32'h3f5a506b; B=32'h8dc54ec8; ctrl=32'b0100;
		#1 A=32'hdb78eefc; B=32'h0df13ec6; ctrl=32'b1101;
		#1 A=32'hc57296e7; B=32'h0434d5bf; ctrl=32'b0000;
		#1 A=32'h410a41b0; B=32'h3f35b666; ctrl=32'b1000;
		#1 A=32'hb36ed7c3; B=32'h5c30f9e0; ctrl=32'b1000;
		#1 A=32'h709a5b99; B=32'h6baee595; ctrl=32'b1110;
		#1 A=32'ha454297f; B=32'hc1e2a1a7; ctrl=32'b1001;
		#1 A=32'ha3b6d6d1; B=32'he910a891; ctrl=32'b1101;
		#1 A=32'h94e82cb2; B=32'hb4d71906; ctrl=32'b1000;
		#1 A=32'h313740fd; B=32'hc2fa5bd3; ctrl=32'b1100;
		#1 A=32'hf9455c0a; B=32'h192cb92c; ctrl=32'b0001;
		#1 A=32'h9807e93b; B=32'h837dc62d; ctrl=32'b1101;
		#1 A=32'hcdd36cb3; B=32'h5455e8cc; ctrl=32'b0001;
		#1 A=32'h3016d911; B=32'h0d4efc9d; ctrl=32'b0110;
		#1 A=32'h168571f7; B=32'ha161b071; ctrl=32'b0111;
		#1 A=32'h5d243a14; B=32'h09643bc0; ctrl=32'b1011;
		#1 A=32'h6c3710e8; B=32'hee0c8f0a; ctrl=32'b0101;
		#1 A=32'h55bb0363; B=32'h9b71dec7; ctrl=32'b1110;
		#1 A=32'h5258927b; B=32'h35947f52; ctrl=32'b1101;
		#1 A=32'h41360431; B=32'hac8b8c78; ctrl=32'b1001;
		#1 A=32'h8f3f9557; B=32'h15fefc66; ctrl=32'b1010;
		#1 A=32'h569167ec; B=32'h2e849032; ctrl=32'b0011;
		#1 A=32'hfe7f2f86; B=32'h44951241; ctrl=32'b0000;
		#1 A=32'h10a6bfe9; B=32'hc25eef0a; ctrl=32'b1011;
		#1 A=32'h550fa7c5; B=32'h80f52b0f; ctrl=32'b1011;
		#1 A=32'h61d0ad79; B=32'hc970233f; ctrl=32'b0001;
		#1 A=32'h7c0416bb; B=32'hc16afaf5; ctrl=32'b0011;
		#1 A=32'h4c502428; B=32'hc6498f8e; ctrl=32'b1011;
		#1 A=32'h286b2ed7; B=32'hb2d59d09; ctrl=32'b1100;
		#1 A=32'h9e30e096; B=32'hacba8440; ctrl=32'b0011;
		#1 A=32'h75e3c4f5; B=32'h42855467; ctrl=32'b0001;
		#1 A=32'h5dd0e400; B=32'ha389d014; ctrl=32'b0010;
		#1 A=32'h263ed93a; B=32'hc1a3136f; ctrl=32'b1011;
		#1 A=32'h12b83a75; B=32'h6e622bce; ctrl=32'b1010;
		#1 A=32'he150e844; B=32'h95ddcc12; ctrl=32'b0100;
		#1 A=32'hf7fa08b4; B=32'h337b2de9; ctrl=32'b0111;
		#1 A=32'h14c112c8; B=32'h75e3843d; ctrl=32'b1100;
		#1 A=32'h4a3547f9; B=32'hefd4cf3f; ctrl=32'b0001;
		#1 A=32'hb36053e0; B=32'h268ed7f7; ctrl=32'b1011;
		#1 A=32'ha01ab403; B=32'hd20fbcb7; ctrl=32'b0010;
		#1 A=32'h37a2b721; B=32'hda6da6d8; ctrl=32'b1010;
		#1 A=32'h0c7311a7; B=32'hb0044334; ctrl=32'b0001;
		#1 A=32'hdbc84070; B=32'h21b19d31; ctrl=32'b0011;
		#1 A=32'hd08025b7; B=32'he7d84687; ctrl=32'b1110;
		#1 A=32'h82a404d1; B=32'h544db748; ctrl=32'b0011;
		#1 A=32'hb08d2073; B=32'h9aaec430; ctrl=32'b0010;
		#1 A=32'h26c76912; B=32'h2c1ae4f7; ctrl=32'b1001;
		#1 A=32'h2fe6cb20; B=32'h291b4b5e; ctrl=32'b1010;
		#1 A=32'h77ed4880; B=32'hb8dfde63; ctrl=32'b1100;
		#1 A=32'hf6df9522; B=32'h065d7460; ctrl=32'b0011;
		#1 A=32'habd304f4; B=32'hb686e7d8; ctrl=32'b0100;
		#1 A=32'h2d65a44c; B=32'hee2a3a69; ctrl=32'b0011;
		#1 A=32'h9cd13d84; B=32'hf19858d6; ctrl=32'b0100;
		#1 A=32'hbce0f9c9; B=32'h842af35e; ctrl=32'b1000;
		#1 A=32'h5dcc4bc3; B=32'hbfc043a7; ctrl=32'b1001;
		#1 A=32'h822447e5; B=32'hb6c66356; ctrl=32'b0111;
		#1 A=32'h9c155feb; B=32'h1959b1a3; ctrl=32'b0010;
		#1 A=32'h04d15b7a; B=32'h1639fbb3; ctrl=32'b1010;
		#1 A=32'h945ab312; B=32'h1f7572bc; ctrl=32'b0101;
		#1 A=32'hc0987589; B=32'hc187b26b; ctrl=32'b1110;
		#1 A=32'h7c723a93; B=32'h32863e52; ctrl=32'b0000;
		#1 A=32'h924b055f; B=32'hf0585252; ctrl=32'b0101;
		#1 A=32'h2c3004fe; B=32'h97609987; ctrl=32'b0000;
		#1 A=32'he4069fe3; B=32'h55cbcaec; ctrl=32'b1010;

    end
endmodule //testbench 

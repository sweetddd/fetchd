package app

import (
	"github.com/cosmos/cosmos-sdk/std"
	"github.com/fetchai/fetchd/app/params"
	enccodec "github.com/fetchai/fetchd/encoding/codec"
)

// MakeEncodingConfig creates an EncodingConfig for testing
func MakeEncodingConfig() params.EncodingConfig {
	encodingConfig := params.MakeEncodingConfig()
	std.RegisterLegacyAminoCodec(encodingConfig.Amino)
	std.RegisterInterfaces(encodingConfig.InterfaceRegistry)
	ModuleBasics.RegisterLegacyAminoCodec(encodingConfig.Amino)
	ModuleBasics.RegisterInterfaces(encodingConfig.InterfaceRegistry)

	enccodec.RegisterInterfaces(encodingConfig.InterfaceRegistry)
	//mb.RegisterInterfaces(encodingConfig.InterfaceRegistry)
	return encodingConfig
}

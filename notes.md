See Circom + SnarkJS diagram at https://docs.circom.io/

Circom - Domain-specific language (DSL) for writing ZKP circuits
Growth16 - Common and popular proving system
.r1cs - Circuit in binary form
.wasm - Need to generate witness. How we specify inputs that we want to keep private while still using them to create a proof.

Trusted setup - generate Common Reference String (CRS) = proving key + verification key
- These are not private keys, but can be publicly available keys
- Any party that needs to generate or verify a proof should have access to them
- If trusted setup done incorrectly, can generate false proofs or falsely claim invalid proofs as verified
- Phase 1 is independent of circuit, and can be used by any ZKP up to a certain size
- Phase 2 is circuit-specific
- Trusted setup -> more mature tooling and ecosystem, and cheap verification costs

Powers of Tau
- Multi-party ceremony where participants contribute entropy to generate secure zk-SNARK parameters
- Assume that at least one participant discards their secret correctly
- .ptau is circuit-independent
- pot12.ptau -> 2^12 - 1 constraints, or ~4000 constraints

Private input signal - string is converted to BigInt

Witness
- Normally is the private input that we use to generate a proof
- In context of Circom, a witness is the complete assignment of all signals both private and public, in a form that the prover software can process

Proving key + .WASM (inputs) -> Witness -> Proof + public output

Proof
- pi_a, pi_b, pi_c are elliptic curve elements
- Metadata on protocol (groth16) and curve (bn128)
- Not useful in isolation, need public output that come with it

`echo -n "foo" | shasum -a 256` - Get SHA-256 hash of 'foo'

circomlibjs - JS wrapper for circomlib

Digital signature scheme
- Generate public + private key
- Generate signature = message + private key
- Verify signature signed by public key

Poseidon hash vs keccak256
- Keccak256 uses more expensive operations like XOR and bitwise rotation
- Poseidon uses simple arithmetic operations over a finite field
- Keccak256 requires many more constraints
- Keccak256 prioritizes security and general hashing performance, not for compatibility with field arithmetic
- Poseidon allows for smaller zk circuits

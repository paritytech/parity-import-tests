contract ValidatorSet {
    /// Issue this log event to signal a desired change in validator set.
    /// This will not lead to a change in active validator set until 
    /// finalizeChange is called.
    ///
    /// Only the last log event of any block can take effect.
    /// If a signal is issued while another is being finalized it may never
    /// take effect.
    /// 
    /// _parent_hash here should be the parent block hash, or the
    /// signal will not be recognized.
    event InitiateChange(bytes32 indexed _parent_hash, address[] _new_set);
    
    /// Get current validator set (last enacted or initial if no changes ever made)
    function getValidators() constant returns (address[] _validators);
    
    /// Called when an initiated change reaches finality and is activated. 
    /// Only valid when msg.sender == SUPER_USER (EIP96, 2**160 - 2)
    ///
    /// Also called when the contract is first enabled for consensus. In this case,
    /// the "change" finalized is the activation of the initial set.
    function finalizeChange();
}

contract TestSet is ValidatorSet {
    address[] pending;
    address[] current = [ 
        0x261580fa70de475d26267d8b1daf303047d3712e,
        0x5547920dbe623cfc7da7ccb26833acb18101e6ff
    ];
    
    function getValidators() constant returns (address[] _validators) {
        return current;
    }
    
    function setValidators(address[] _new) {
        pending = _new;
        InitiateChange(block.blockhash(block.number - 1), _new);
    }
    
    function finalizeChange() {
        require(msg.sender == 2**160 - 2);
        current = pending;
    }
}
local _RhkC = DYCInfoPanel
local function _I9Pv(_uusB, ...)
    local _dB6j = _uusB.dycOldOnUpdate and _uusB.dycOldOnUpdate(_uusB, ...)
    local _59oF = _uusB.owner
    local _pdDj = _59oF and _59oF.components and _59oF.components.playercontroller
    local _ieSu = _pdDj and (_pdDj.LMBaction and _pdDj.LMBaction.target or _pdDj.RMBaction and _pdDj.RMBaction.target)
    local _iwg8 = _59oF and _59oF.HUD and _59oF.HUD.controls
    local _68g1 = _iwg8 and _iwg8:GetTooltip()
    local _HpzU = _RhkC.objectDetailWindow
    if not _RhkC.cfgs.hovertext and (_ieSu or (_HpzU and _HpzU.hoveredWidget)) and _uusB.text and _uusB.text.shown then _uusB.text:Hide() end
    if not _RhkC.cfgs.hovertext and (_ieSu or (_HpzU and _HpzU.hoveredWidget)) and _uusB.secondarytext and _uusB.secondarytext.shown then _uusB.secondarytext:Hide() end
    return _dB6j
end
local function _almK(_0TLg)
    _0TLg.dycOldOnUpdate = _0TLg.OnUpdate
    _0TLg.OnUpdate = _I9Pv
end
return _almK

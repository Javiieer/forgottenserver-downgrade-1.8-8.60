#ifndef FS_FAMILIAR_H
#define FS_FAMILIAR_H

#include "player.h"
#include <string>

namespace Familiar {

static constexpr int32_t STORAGE_FAMILIAR_SUMMON_TIME = 845232;
static constexpr int32_t STORAGE_FAMILIAR_TIMER_10 = 845230;
static constexpr int32_t STORAGE_FAMILIAR_TIMER_60 = 845231;

std::string getFamiliarName(const Player* player);
bool dispellFamiliar(Player* player);
bool createFamiliar(Player* player, const std::string& familiarName, uint32_t timeLeft);
bool createFamiliarSpell(Player* player, uint32_t spellId);

}

#endif

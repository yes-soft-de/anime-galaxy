<?php

namespace App\Entity;

use App\Repository\WatchListRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=WatchListRepository::class)
 */
class WatchList
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="integer")
     */
    private $userId;

    /**
     * @ORM\Column(type="integer")
     */
    private $animeId;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?int
    {
        return $this->userId;
    }

    public function setUserId(int $userId): self
    {
        $this->userId = $userId;

        return $this;
    }

    public function getAnimeId(): ?int
    {
        return $this->animeId;
    }

    public function setAnimeId(int $animeId): self
    {
        $this->animeId = $animeId;

        return $this;
    }
}

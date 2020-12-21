<?php

namespace App\Entity;

use App\Repository\RatingEpisodeRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RatingEpisodeRepository::class)
 */
class RatingEpisode
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string")
     */
    private $userID;

    /**
     * @ORM\Column(type="integer")
     */
    private $episodeID;

    /**
     * @ORM\Column(type="integer")
     */
    private $rateValue;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $creationDate;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?string
    {
        return $this->userID;
    }

    public function setUserID(string $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getEpisodeID(): ?int
    {
        return $this->episodeID;
    }

    public function setEpisodeID(int $episodeID): self
    {
        $this->episodeID = $episodeID;

        return $this;
    }

    public function getRateValue(): ?int
    {
        return $this->rateValue;
    }

    public function setRateValue(int $rateValue): self
    {
        $this->rateValue = $rateValue;

        return $this;
    }

    public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    public function setCreationDate(): self
    {
        $this->creationDate = new \DateTime('Now');

        return $this;
    }
}
